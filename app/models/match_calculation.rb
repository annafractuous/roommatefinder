class MatchCalculation < ActiveRecord::Base
  def self.find_matches(user)
    set = User.where.not(id: user.id)

    set = reject_wrong_gender(user, set) if user.desired_match_trait.gender
    set = reject_wrong_rent(user, set) if user.max_rent
    set = reject_wrong_age(user, set) if user.desired_match_trait.min_age && user.desired_match_trait.max_age
    set = reject_wrong_city(user, set) if user.desired_match_trait.city
    set = reject_wrong_move_in_date(user, set) if user.desired_match_trait[:move_in_date]

    set.each do |match|
      run_match_calculations(user, match)
    end
    user.matches
  end

  ## had to break this into another method because needs to be run
  ## on a single match in match_connections_controller when one
  ## user selects interest in another
  def self.run_match_calculations(user, match)
    category_compat_scores = all_category_compatibility_scores(user, match) # => [63, 45, 87]
    category_compat_scores = blank_category_sanitizer(category_compat_scores)
    compatibility_score = self.calculate_compatibility_score(category_compat_scores)

    connection = user.match_connections.find_or_create_by(match: match)
    connection.compatibility = compatibility_score
    connection.save
  end

  ## get mutual compatibility scores for each category ##
  def self.all_category_compatibility_scores(user, match)
    categories = question_tables.reject { |table| table.starts_with?("desired") }
    # => ["cleanlinesses", "habits", "schedules"]
    categories.each_with_object([]) do |category, compat_scores|
      compat_scores << self.mutual_compatibility_score_per_category(user, match, category)
    end
  end

  ## calculate mutual compatibility for category ##
  def self.mutual_compatibility_score_per_category(user, match, category)
    user_to_match_percentage = compatibility_percentage_per_category(user, match, category)
    match_to_user_percentage = compatibility_percentage_per_category(match, user, category)

    # -1 is a flag that the category has not been filled out at all
    if user_to_match_percentage == -1 || match_to_user_percentage == -1
      return -1
    else
      compatibility = Math.sqrt(user_to_match_percentage * match_to_user_percentage).to_i
    end
  end

  ## check one-way compatibility for a single category ##
  def self.compatibility_percentage_per_category(user, match, category)
    ## weighted responses to 'how important is this to you' ##
    conversion_hash = { 1 => 0, 2 => 1, 3 => 10, 4 => 250 }

    total_possible_points = 0
    points_earned = 0
    ## get table from category name ##
    table = Object.const_get(category.classify) # e.g. Cleanliness table

    # -1 is a flag that the category has not been filled out at all
    if user.send(category.singularize).all_input_columns_nil?
      return -1
    else
      question_columns = table.user_input_columns
      # => ["kitchen", "bathroom", "common_space"]
      question_columns.each do |attrb|
        desired_cat = "desired_#{category}".singularize

        if user.send(desired_cat).send(attrb)
          desired_answers = user.send(desired_cat).send(attrb).split('') # "45" => ["4", "5"]
          importance = user.send(desired_cat).send("#{attrb}_importance")
          points = conversion_hash[importance]
          total_possible_points += points

          answer = match.send(category.singularize).send(attrb)
          points_earned += points if desired_answers.include?(answer.to_s)
        end
      end
      total_possible_points != 0 ? (points_earned / total_possible_points.to_f * 100).to_i : 1
    end
  end

  def self.blank_category_sanitizer(scores_array)
    # scores_array => [87, 63, -1]
    scores_array.reject! { |score| score == -1 }
    # scores_array => [87, 63]
    # total compatibility score should be reduced by 1/3 for each nil category
    if scores_array.size == 0
      scores_array = [1]
    elsif scores_array.size <= 2
      scores_array.map { |score| (score * (0.33 * scores_array.length)).to_i }
    else
      scores_array
    end
  end
  ## calculate total mutual compatibility ##
  def self.calculate_compatibility_score(category_scores) 
    if category_scores.size <= 2
      score = Math.sqrt(category_scores.first * category_scores.last.to_f).to_i
      score == 0 ? 1 : score
    else
      first = category_scores.shift.to_f
      second = category_scores.shift.to_f
      score_so_far = Math.sqrt(first * second).to_i
      if score_so_far == 0
        score_so_far = 1
      end
      category_scores.unshift(score_so_far)
      calculate_compatibility_score(category_scores)
    end
  end

  def self.reject_wrong_rent(user, set)
    max_rent_with_cushion = user.max_rent + 200
    set.where("max_rent <= ?", max_rent_with_cushion)
  end

  def self.reject_wrong_gender(user, set)
    your_gender = user.desired_match_trait.gender
    your_gender == "Any" ? set : set.where("users.gender = ?", your_gender)
  end

  def self.reject_wrong_age(user, set)
    min_birth_year = DateTime.now - (user.desired_match_trait.min_age.years - 1.years)
    max_birth_year =  DateTime.now - (user.desired_match_trait.max_age.years + 1.years)
    set.where("birthdate < ? AND birthdate > ?", min_birth_year, max_birth_year)
  end

  def self.reject_wrong_city(user, set)
    set.joins(:desired_match_trait).where("desired_match_traits.city = ?", user.desired_match_trait.city)
  end

  def self.reject_wrong_move_in_date(user, set)
    min_date = user.desired_match_trait[:move_in_date] - 61.days
    max_date = user.desired_match_trait[:move_in_date] + 61.days
    set.joins(:desired_match_trait).where("desired_match_traits.move_in_date > ? AND desired_match_traits.move_in_date < ?", min_date, max_date)
  end

  def self.question_tables
    ActiveRecord::Base.connection.tables.reject { |t| ["users", "match_connections", "schema_migrations"].include?(t) }
  end
  
  def self.user_columns
    User.column_names.reject { |col| ["id", "name", "username", "email", "password_digest", "created_at", "updated_at"].include?(col) }
  end
end


  
