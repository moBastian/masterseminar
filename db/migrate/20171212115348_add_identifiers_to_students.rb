class AddIdentifiersToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :fingerprint, :text
    add_column :students, :ip, :text
  end
end
