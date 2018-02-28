class RemoveNeedlessThings < ActiveRecord::Migration[5.0]
  def change
    remove_column :tests, :level
    remove_column :tests, :type_info
    remove_column :students, :specific_needs
    remove_column :students, :migration
    remove_column :students, :birthdate
    drop_table :faqs
  end

end
