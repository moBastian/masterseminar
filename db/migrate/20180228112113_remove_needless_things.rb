class RemoveNeedlessThings < ActiveRecord::Migration[5.0]
  def change
    remove_column :tests, :level
    remove_column :tests, :type_info
    remove_column :tests, :type
    remove_column :tests, :answers
    remove_column :tests, :student_access
    remove_column :tests, :archive
    remove_column :groups, :export
    remove_column :items, :mediapath
    remove_column :students, :specific_needs
    remove_column :students, :migration
    remove_column :students, :birthdate
    remove_column :users, :school
    remove_column :users, :occupation
    drop_table :faqs
    drop_table :news
  end

end
