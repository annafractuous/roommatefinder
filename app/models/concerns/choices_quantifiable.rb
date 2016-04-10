module ChoicesQuantifiable
  module Cleanliness
    # use for all cleanliness methods
    def cleanliness_quantified
      {1 => "Hoarder", 2 => "Controlled Mess", 3 => "Average", 4 => "Presentable", 5 => "Museum"}
    end
  end

  module Habit
    # use for drinking, four_twenty, and partying
    def wildness_quantified
      {1 => "Never", 2 => "Rarely", 3 => "Occasionally", 4 => "Regularly", 5 => "Fear and Loathing"}
    end

    # use for music
    def music_quantified
       {1 => "What's Music", 2 => "Strictly Headphones", 3 => "I Like Music about as Much as the Average Person", 4 => "Rock Out Regularly", 5 => "I'm in a Band"}
    end

    # use for overnight_visitors
    def visitors_quantified
       {1 => "Never", 2 => "Rarely", 3 => "Occasionally", 4 => "Regularly", 5 => "Never Alone"}
    end
  end

  module Schedule
    def work_schedule_quantified
      {1 => "Unemployed", 2=> "Remote/Freelance", 3 => "9-5", 4 => "Graveyard Shift", 5 => "Workaholic"}
    end
    
    def sleep_schedule_quantified
      {1 => "Responsible Adult", 2 => "Late Riser", 3 => "Nocturnal", 4 => "Daytime Sleeper", 5 => "Never Sleep"}
    end

    def bathroom_schedule_quantified
      {1 => "Before 6am", 2 => "6-7", 3 => "7-8", 4 => "8-10", 5 => "Evening Showerer"}
    end

    def kitchen_schedule_quantified
      {1 => "Never Cook", 2 => "Prepared Foods", 3 => "Sometimes", 4 => "Most Nights", 5 => "Anthony Bourdain"}
    end
  end
end
