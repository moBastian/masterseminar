class CreateFakenames < ActiveRecord::Migration[5.0]
  def change
    create_table :fakenames do |t|
      t.text :name
      t.timestamps
    end
  end
end
