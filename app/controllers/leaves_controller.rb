class LeavesController < ApplicationController
  before_action :set_leave, only: [ :show, :edit, :update, :destroy, :approve, :reject ]

  def index
    @all_leaves = Leave.includes(:employee).all
    @all_leaves = @all_leaves.by_status(params[:status]) if params[:status].present?
    @all_leaves = @all_leaves.by_type(params[:leave_type]) if params[:leave_type].present?
    @all_leaves = @all_leaves.recent

    respond_to do |format|
      format.html do
        @current_page = (params[:page] || 1).to_i
        @total_pages = Leave.total_pages(@all_leaves)
        @leaves = @all_leaves.page_records(params[:page])
      end
      format.csv do
        send_data generate_csv(@all_leaves), filename: "cuti-#{Date.current}.csv", type: "text/csv"
      end
    end
  end

  def show
  end

  def new
    @leave = Leave.new
    @leave.employee_id = params[:employee_id] if params[:employee_id]
    @employees = Employee.active.order(:first_name)
  end

  def create
    @leave = Leave.new(leave_params)
    if @leave.save
      redirect_to @leave, notice: "Pengajuan cuti berhasil dibuat."
    else
      @employees = Employee.active.order(:first_name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employees = Employee.active.order(:first_name)
  end

  def update
    if @leave.update(leave_params)
      redirect_to @leave, notice: "Data cuti berhasil diperbarui."
    else
      @employees = Employee.active.order(:first_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @leave.destroy
    redirect_to leaves_path, notice: "Data cuti berhasil dihapus.", status: :see_other
  end

  def approve
    @leave.update(status: :approved, approved_by: "Admin")
    Activity.log(action: "leave_approved", trackable: @leave, description: "Cuti #{@leave.employee.full_name} disetujui")
    redirect_to @leave, notice: "Cuti telah disetujui."
  end

  def reject
    @leave.update(status: :rejected, approved_by: "Admin")
    Activity.log(action: "leave_rejected", trackable: @leave, description: "Cuti #{@leave.employee.full_name} ditolak")
    redirect_to @leave, notice: "Cuti telah ditolak."
  end

  private

  def set_leave
    @leave = Leave.find(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:employee_id, :leave_type, :start_date, :end_date, :reason, :status, :approved_by)
  end

  def generate_csv(leaves)
    require "csv"
    CSV.generate(headers: true) do |csv|
      csv << ["Karyawan", "Tipe Cuti", "Tanggal Mulai", "Tanggal Selesai", "Durasi", "Alasan", "Status", "Disetujui Oleh"]
      leaves.each do |l|
        csv << [l.employee.full_name, l.leave_type.humanize, l.start_date, l.end_date, l.duration_text, l.reason, l.status.humanize, l.approved_by]
      end
    end
  end
end
