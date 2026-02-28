class CreateAttendances < ActiveRecord::Migration[7.2]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :date, null: false
      t.datetime :check_in
      t.datetime :check_out
      t.integer :status, default: 0, null: false
      t.text :notes

      t.timestamps
    end

    add_index :attendances, :date
    add_index :attendances, :status
    add_index :attendances, [ :employee_id, :date ], unique: true
  end
end
