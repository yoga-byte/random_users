# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.string :uuid, primary_key: true
      t.string :gender
      t.jsonb :name
      t.jsonb :location
      t.integer :age

      t.timestamps
    end
  end
end
