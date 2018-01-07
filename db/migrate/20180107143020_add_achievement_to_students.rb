class AddAchievementToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :achievement, :text
  end
end
