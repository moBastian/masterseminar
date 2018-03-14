class AddBadgeDataToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :login_times, :integer
    add_column :students, :feedback_send, :boolean
    add_column :students, :survey_done, :boolean
  end
end
