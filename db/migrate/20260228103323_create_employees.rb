class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :employee_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :department, null: false
      t.string :position, null: false
      t.date :hire_date, null: false
      t.decimal :salary, precision: 12, scale: 2, default: 0
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :employees, :employee_id, unique: true
    add_index :employees, :email, unique: true
    add_index :employees, :department
    add_index :employees, :status
  end
end
