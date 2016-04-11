module InputColumnable

    def all_input_columns_nil?
      question_columns = self.class.user_input_columns
      # #any returns false if all values are nil
      !question_columns.map { |col| self.send(col) }.any?
    end

  module ClassMethods

    def user_input_columns
      self.column_names.reject { |col| ["id", "created_at", "updated_at", "user_id"].include?(col)}
    end
  end

end
