class AddExportToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :export, :boolean
  end
end
