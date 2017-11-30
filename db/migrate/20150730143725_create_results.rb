# -*- encoding : utf-8 -*-
class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :student_id
      t.integer :measurement_id
      t.text :items
      t.text :responses
      t.float :total

      t.timestamps
    end
  end
end
