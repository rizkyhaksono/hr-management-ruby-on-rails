class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.string :action, null: false
      t.string :trackable_type
      t.integer :trackable_id
      t.string :description, null: false
      t.timestamps
    end

    add_index :activities, [:trackable_type, :trackable_id]
    add_index :activities, :created_at
  end
end
