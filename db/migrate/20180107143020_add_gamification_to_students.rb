class AddGamificationToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :achievement, :text
    add_column :students, :points, :integer
  end
end
