class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.text :feedbacktext
      t.integer  :group_id
      t.timestamps
    end
  end
end
