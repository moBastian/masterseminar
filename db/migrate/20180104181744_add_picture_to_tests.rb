class AddPictureToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :picture, :text
  end
end
