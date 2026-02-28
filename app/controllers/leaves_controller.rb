class LeavesController < ApplicationController
  before_action :set_leave, only: [ :show, :edit, :update, :destroy, :approve, :reject ]

  def index
    @leaves = Leave.includes(:employee).all
    @leaves = @leaves.by_status(params[:status]) if params[:status].present?
    @leaves = @leaves.by_type(params[:leave_type]) if params[:leave_type].present?
    @leaves = @leaves.recent.page_records(params[:page])
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
    redirect_to @leave, notice: "Cuti telah disetujui."
  end

  def reject
    @leave.update(status: :rejected, approved_by: "Admin")
    redirect_to @leave, notice: "Cuti telah ditolak."
  end

  private

  def set_leave
    @leave = Leave.find(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:employee_id, :leave_type, :start_date, :end_date, :reason, :status, :approved_by)
  end
end
