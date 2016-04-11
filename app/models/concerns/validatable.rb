module Validatable

  def preference_and_importance_entered?
    importance_attributes = self.attributes.keys.select { |attrb| attrb.include?("_importance") }
    importance_attributes.each do |attrb|
      question = attrb.split("_importance")[0]
      if self.send(question) && !self.send(attrb)
        errors.add(attrb.to_sym, "must be filled out")
      elsif !self.send(question) && self.send(attrb)
        errors.add(question.to_sym, "must be filled out")
      end
    end
  end

  def cannot_select_pick_one
    self.class.user_input_columns.each do |col|
      if self.send(col) == 0
        errors.add(col.to_sym, "must be a real value, not 'pick one'")
      end
    end
  end

end
