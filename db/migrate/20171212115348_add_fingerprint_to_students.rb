class AddFingerprintToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :fingerprint, :text
  end
end
