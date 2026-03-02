class DashboardController < ApplicationController
  def index
    @total_employees = Employee.count
    @active_employees = Employee.active.count
    @pending_leaves = Leave.pending.count
    @today_attendances = Attendance.today.count

    @recent_leaves = Leave.includes(:employee).recent.limit(5)
    @recent_attendances = Attendance.includes(:employee).today.limit(10)
    @recent_activities = Activity.recent.limit(8)

    @department_stats = Employee.active.group(:department).count.sort_by { |_, v| -v }
    @leave_type_stats = Leave.this_year.group(:leave_type).count
    @monthly_attendance = Attendance.this_month.group(:status).count

    @attendance_trend = Attendance.where(date: 6.days.ago..Date.current)
      .group(:date).count.sort_by(&:first)
    @present_trend = Attendance.where(date: 6.days.ago..Date.current, status: :present)
      .group(:date).count
  end
end
