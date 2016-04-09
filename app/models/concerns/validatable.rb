module Validatable

  def preference_and_importance_entered?
    importance_attributes = self.attributes.keys.select { |attrb| attrb.include?("_importance") }
    importance_attributes.each do |attrb|
      question = attrb.split("_importance")[0]
      if self.send(question) != 0 && self.send(attrb) == 0
        errors.add(attrb.to_sym, "must be filled out")
      elsif self.send(attrb) != 0 && self.send(question) == 0
        errors.add(question.to_sym, "must be filled out")
      end
    end
  end

end
