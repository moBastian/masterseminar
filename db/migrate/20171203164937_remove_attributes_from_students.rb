class RemoveAttributesFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :specific_needs
    remove_column :students, :migration
    remove_column :students, :birthdate
  end
end
