module InputColumnable

  def user_input_columns
    self.column_names.reject { |col| ["id", "created_at", "updated_at", "user_id"].include?(col)}
  end

end
