class RemoveAttributesFromTests < ActiveRecord::Migration[5.0]
  def change
    remove_column :tests, :level
  end
end
