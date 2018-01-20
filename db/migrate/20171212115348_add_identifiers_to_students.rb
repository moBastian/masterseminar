class AddIdentifiersToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :fingerprint, :text
    add_column :students, :ip, :text
    add_column :students, :age, :text
  end
end
