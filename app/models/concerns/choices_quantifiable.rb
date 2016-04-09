module ChoicesQuantifiable
  def cleanliness_quantified
    {1 => "Hoarder", 2 => "Controlled Mess", 3 => "Average", 4 => "Presentable", 5 =>  "Museum"}
  end

  def habits_quantified
    {1 => "Never", 2 => "Rarely", 3 => "Occasionally", 4 => "Regularly", 5 => "All the Time"}
  end

  def work_schedule_quantified
    {1 =>"Unemployed", 2=> "Remote/Freelance",3 => "9-5", 4 =>"Graveyard Shift",5 =>"Workaholic"}
  end
  
  def sleep_schedule_quantified
    {1 => "Normal", 2 =>"Nocturnal", 3 => "Long",4 =>  "Short", 5 => "Never Sleep"}
  end
  
  def bathroom_schedule_quantified
     #{}"5-8", "8-10", "10-Noon", "Night Shower", "Daily Shaver"
    {1 => "5-8", 2 =>"8-10", 3 => "10-Noon",4 =>  "Night Shower", 5 => "Daily Shaver"}
  end

  def kitchen_schedule_quantified
    {1 => "Never Cook", 2 =>"Prepared Foods", 3 => "Sometimes",4 =>  "Most Nights", 5 => "Anthony Bourdain"}
  end

end