class EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :edit, :update, :destroy ]

  def index
    @all_employees = Employee.all
    @all_employees = @all_employees.search(params[:search]) if params[:search].present?
    @all_employees = @all_employees.by_department(params[:department]) if params[:department].present?
    @all_employees = @all_employees.by_status(params[:status]) if params[:status].present?
    @all_employees = @all_employees.recent

    respond_to do |format|
      format.html do
        @current_page = (params[:page] || 1).to_i
        @total_pages = Employee.total_pages(@all_employees)
        @employees = @all_employees.page_records(params[:page])
        @departments = Employee.distinct.pluck(:department).compact.sort
      end
      format.csv do
        send_data generate_csv(@all_employees), filename: "karyawan-#{Date.current}.csv", type: "text/csv"
      end
    end
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
    name = @employee.full_name
    @employee.destroy
    Activity.log(action: "employee_deleted", description: "Karyawan dihapus: #{name}")
    redirect_to employees_path, notice: "Karyawan berhasil dihapus.", status: :see_other
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:employee_id, :first_name, :last_name, :email, :phone, :department, :position, :hire_date, :salary, :status, :leave_quota)
  end

  def generate_csv(employees)
    require "csv"
    CSV.generate(headers: true) do |csv|
      csv << ["ID Karyawan", "Nama Depan", "Nama Belakang", "Email", "Telepon", "Departemen", "Jabatan", "Tanggal Masuk", "Gaji", "Status"]
      employees.each do |e|
        csv << [e.employee_id, e.first_name, e.last_name, e.email, e.phone, e.department, e.position, e.hire_date, e.salary, e.status]
      end
    end
  end
end
