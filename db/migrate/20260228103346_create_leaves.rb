class CreateLeaves < ActiveRecord::Migration[7.2]
  def change
    create_table :leaves do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :leave_type, default: 0, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.text :reason
      t.integer :status, default: 0, null: false
      t.string :approved_by
      t.integer :days_count, default: 1

      t.timestamps
    end

    add_index :leaves, :leave_type
    add_index :leaves, :status
    add_index :leaves, [ :start_date, :end_date ]
  end
end
