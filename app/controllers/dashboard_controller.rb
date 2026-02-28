class DashboardController < ApplicationController
  def index
    @total_employees = Employee.count
    @active_employees = Employee.active.count
    @pending_leaves = Leave.pending.count
    @today_attendances = Attendance.today.count

    @recent_leaves = Leave.includes(:employee).recent.limit(5)
    @recent_attendances = Attendance.includes(:employee).today.limit(10)

    @department_stats = Employee.active.group(:department).count
    @leave_type_stats = Leave.this_year.group(:leave_type).count
    @monthly_attendance = Attendance.this_month.group(:status).count
  end
end
