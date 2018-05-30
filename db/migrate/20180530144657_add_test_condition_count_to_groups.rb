class AddTestConditionCountToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :test_condition_count, :integer
  end
end
