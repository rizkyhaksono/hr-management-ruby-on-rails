class EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :edit, :update, :destroy ]

  def index
    @employees = Employee.all
    @employees = @employees.search(params[:search]) if params[:search].present?
    @employees = @employees.by_department(params[:department]) if params[:department].present?
    @employees = @employees.by_status(params[:status]) if params[:status].present?
    @employees = @employees.recent.page_records(params[:page])
    @departments = Employee.distinct.pluck(:department).compact.sort
  end

  def show
    @recent_leaves = @employee.leaves.recent.limit(5)
    @recent_attendances = @employee.attendances.recent.limit(10)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: "Karyawan berhasil ditambahkan."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee, notice: "Data karyawan berhasil diperbarui."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, notice: "Karyawan berhasil dihapus.", status: :see_other
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:employee_id, :first_name, :last_name, :email, :phone, :department, :position, :hire_date, :salary, :status)
  end
end
