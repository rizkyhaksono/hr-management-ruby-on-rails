class AddLeaveQuotaToEmployees < ActiveRecord::Migration[7.2]
  def change
    add_column :employees, :leave_quota, :integer, default: 12, null: false
  end
end
