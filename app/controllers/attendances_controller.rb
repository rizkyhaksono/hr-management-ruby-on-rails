class AttendancesController < ApplicationController
  before_action :set_attendance, only: [ :show, :edit, :update, :destroy ]

  def index
    @all_attendances = Attendance.includes(:employee).all
    @all_attendances = @all_attendances.by_status(params[:status]) if params[:status].present?
    @all_attendances = @all_attendances.where(date: params[:date]) if params[:date].present?
    @all_attendances = @all_attendances.where(employee_id: params[:employee_id]) if params[:employee_id].present?
    @all_attendances = @all_attendances.recent

    respond_to do |format|
      format.html do
        @current_page = (params[:page] || 1).to_i
        @total_pages = Attendance.total_pages(@all_attendances)
        @attendances = @all_attendances.page_records(params[:page])
        @employees = Employee.active.order(:first_name)
      end
      format.csv do
        send_data generate_csv(@all_attendances), filename: "absensi-#{Date.current}.csv", type: "text/csv"
      end
    end
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
      Activity.log(action: "attendance_bulk", description: "Absensi massal: #{success_count} karyawan dicatat")
      redirect_to attendances_path, notice: "#{success_count} absensi berhasil dicatat."
    end
  end

  def calendar
    @month = params[:month] ? Date.parse(params[:month] + "-01") : Date.current.beginning_of_month
    @employee = params[:employee_id].present? ? Employee.find(params[:employee_id]) : nil
    @employees = Employee.active.order(:first_name)

    scope = Attendance.where(date: @month.beginning_of_month..@month.end_of_month)
    scope = scope.where(employee_id: @employee.id) if @employee

    @attendances_by_date = scope.group(:date, :status).count
    @summary = scope.group(:status).count
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:employee_id, :date, :check_in, :check_out, :status, :notes)
  end

  def generate_csv(attendances)
    require "csv"
    CSV.generate(headers: true) do |csv|
      csv << ["Karyawan", "Tanggal", "Jam Masuk", "Jam Keluar", "Durasi", "Status", "Catatan"]
      attendances.each do |a|
        csv << [a.employee.full_name, a.date, a.check_in&.strftime("%H:%M"), a.check_out&.strftime("%H:%M"), a.working_hours_text, a.status, a.notes]
      end
    end
  end
end
