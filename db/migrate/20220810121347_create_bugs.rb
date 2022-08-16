# frozen_string_literal: true

class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title, null: false, default: ''
      t.string :description, default: ''
      t.date :deadline,        null: false
      t.integer :type_of_bug,  null: false, default: 0
      t.integer :status,       null: false, default: 0
      t.references :creator,    foreign_key: { to_table: :users }
      t.references :developer,  foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
