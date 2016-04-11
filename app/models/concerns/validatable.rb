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

end
