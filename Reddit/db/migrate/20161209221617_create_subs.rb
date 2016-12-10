class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false

      t.timestamps null: false
    end

    add_index :subs, :moderator_id
    add_index :subs, :name, unique: true
  end
end
