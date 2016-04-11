module UserMatchifiable
  module MatchBy

    def match_by_has_and_wants_attribute(attribute, user1)
      column_count = self.send(attribute).class.user_columns.count
     return true if self.quantify_attribute(attribute)  >= (4 * column_count) && user1.quantify_attribute(attribute) >= (4 * column_count)

     return false
    end
  end
  
  module MatchQuantifiable
    def quantify_attribute(attribute)
      Cleanliness.user_columns.inject(0) do |sum, col|
        if self.send(attribute).send(col) != nil
          sum + self.send(attribute).send(col)
        else
          return "Incomplete cleanliness profile, unable to match"
        end
      end
    end
  end
end