class AttendancesController < ApplicationController
  before_action :set_attendance, only: [ :show, :edit, :update, :destroy ]

  def index
    @attendances = Attendance.includes(:employee).all
    @attendances = @attendances.by_status(params[:status]) if params[:status].present?
    if params[:date].present?
      @attendances = @attendances.where(date: params[:date])
    end
    if params[:employee_id].present?
      @attendances = @attendances.where(employee_id: params[:employee_id])
    end
    @attendances = @attendances.recent.page_records(params[:page])
    @employees = Employee.active.order(:first_name)
  end

  def show
  end

  def new
    @attendance = Attendance.new(date: Date.current)
    @attendance.employee_id = params[:employee_id] if params[:employee_id]
    @employees = Employee.active.order(:first_name)
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to @attendance, notice: "Absensi berhasil dicatat."
    else
      @employees = Employee.active.order(:first_name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employees = Employee.active.order(:first_name)
  end

  def update
    if @attendance.update(attendance_params)
      redirect_to @attendance, notice: "Data absensi berhasil diperbarui."
    else
      @employees = Employee.active.order(:first_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance.destroy
    redirect_to attendances_path, notice: "Data absensi berhasil dihapus.", status: :see_other
  end

  def bulk_create
    @employees = Employee.active.order(:first_name)
    if request.post?
      date = params[:date] || Date.current
      success_count = 0
      params[:attendances]&.each do |emp_id, attrs|
        next if attrs[:status].blank?
        attendance = Attendance.find_or_initialize_by(employee_id: emp_id, date: date)
        attendance.assign_attributes(
          status: attrs[:status],
          check_in: attrs[:check_in],
          check_out: attrs[:check_out],
          notes: attrs[:notes]
        )
        success_count += 1 if attendance.save
      end
      redirect_to attendances_path, notice: "#{success_count} absensi berhasil dicatat."
    end
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:employee_id, :date, :check_in, :check_out, :status, :notes)
  end
end
