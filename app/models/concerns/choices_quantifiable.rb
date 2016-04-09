module ChoicesQuantifiable
  module Cleanliness
    def cleanliness_quantified
      {1 => "Hoarder", 2 => "Controlled Mess", 3 => "Average", 4 => "Presentable", 5 => "Museum"}
    end
  end

  module Habit
    def habits_quantified
      {1 => "Never", 2 => "Rarely", 3 => "Occasionally", 4 => "Regularly", 5 => "Fear and Loathing"}
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
