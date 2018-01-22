class AddIdentifiersToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :fingerprint, :text
    add_column :students, :ip, :text
    add_column :students, :age, :integer
    add_column :students, :email, :text
  end
end
