module UserMatchifiable
  module MatchBy

    def match_by_mutual_cleanliness(user1)
     return true if self.quantify_cleanliness  >= 12 && user1.quantify_cleanliness >= 12
     return false
    end
  end
  
  module MatchQuantifiable
    def quantify_cleanliness
      Cleanliness.user_columns.inject(0) do |sum, col|
        if self.cleanliness.send(col) != nil
          sum + self.cleanliness.send(col)
        else
          return "Incomplete cleanliness profile"
        end
      end
    end
  end
end