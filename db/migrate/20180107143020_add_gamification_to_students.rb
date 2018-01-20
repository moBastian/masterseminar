class AddGamificationToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :achievement, :text
    add_column :students, :points, :integer
    add_column :students, :first_accept, :text
  end
end
