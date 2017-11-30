class AddStudentToMeasurement < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :stuId, :integer
  end
end
