class ReportsController < ApplicationController
  def index
    @date_from = params[:date_from] ? Date.parse(params[:date_from]) : Date.current.beginning_of_month
    @date_to = params[:date_to] ? Date.parse(params[:date_to]) : Date.current
    @department = params[:department]

    employees_scope = Employee.all
    employees_scope = employees_scope.where(department: @department) if @department.present?

    @total_employees = employees_scope.count
    @active_employees = employees_scope.active.count
    @new_hires = employees_scope.where("hire_date >= ?", Date.current.beginning_of_month).count

    attendances_scope = Attendance.where(date: @date_from..@date_to)
    attendances_scope = attendances_scope.joins(:employee).where(employees: { department: @department }) if @department.present?
    @total_attendances = attendances_scope.count
    @attendance_by_status = attendances_scope.group(:status).count

    @attendance_by_day = attendances_scope.group(:date).count.sort_by(&:first)
    @present_by_day = attendances_scope.where(status: :present).group(:date).count

    leaves_scope = Leave.where("start_date >= ? OR end_date <= ?", @date_from, @date_to)
    leaves_scope = leaves_scope.joins(:employee).where(employees: { department: @department }) if @department.present?
    @leaves_by_type = leaves_scope.group(:leave_type).count
    @leaves_by_status = leaves_scope.group(:status).count
    @total_leave_days = leaves_scope.where(status: :approved).sum(:days_count)

    @department_stats = Employee.active.group(:department).count.sort_by { |_, v| -v }
    @departments = Employee.distinct.pluck(:department).compact.sort
  end
end
