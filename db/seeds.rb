puts "🌱 Seeding HR System data..."

# Create employees
employees_data = [
  { employee_id: "EMP-001", first_name: "Budi", last_name: "Santoso", email: "budi.santoso@perusahaan.com", phone: "081234567890", department: "IT", position: "Senior Developer", hire_date: "2020-01-15", salary: 15000000, status: :active },
  { employee_id: "EMP-002", first_name: "Sari", last_name: "Dewi", email: "sari.dewi@perusahaan.com", phone: "081234567891", department: "HR", position: "HR Manager", hire_date: "2019-03-20", salary: 18000000, status: :active },
  { employee_id: "EMP-003", first_name: "Ahmad", last_name: "Hidayat", email: "ahmad.hidayat@perusahaan.com", phone: "081234567892", department: "Finance", position: "Accountant", hire_date: "2021-06-01", salary: 12000000, status: :active },
  { employee_id: "EMP-004", first_name: "Rina", last_name: "Wati", email: "rina.wati@perusahaan.com", phone: "081234567893", department: "Marketing", position: "Marketing Lead", hire_date: "2020-09-10", salary: 14000000, status: :active },
  { employee_id: "EMP-005", first_name: "Deni", last_name: "Pratama", email: "deni.pratama@perusahaan.com", phone: "081234567894", department: "IT", position: "Junior Developer", hire_date: "2022-02-14", salary: 8000000, status: :active },
  { employee_id: "EMP-006", first_name: "Maya", last_name: "Sari", email: "maya.sari@perusahaan.com", phone: "081234567895", department: "Operations", position: "Operations Manager", hire_date: "2018-11-05", salary: 16000000, status: :active },
  { employee_id: "EMP-007", first_name: "Rudi", last_name: "Hartono", email: "rudi.hartono@perusahaan.com", phone: "081234567896", department: "Sales", position: "Sales Executive", hire_date: "2021-04-22", salary: 10000000, status: :active },
  { employee_id: "EMP-008", first_name: "Lina", last_name: "Kusuma", email: "lina.kusuma@perusahaan.com", phone: "081234567897", department: "IT", position: "DevOps Engineer", hire_date: "2020-07-01", salary: 14000000, status: :active },
  { employee_id: "EMP-009", first_name: "Fajar", last_name: "Nugroho", email: "fajar.nugroho@perusahaan.com", phone: "081234567898", department: "Engineering", position: "Tech Lead", hire_date: "2019-01-10", salary: 20000000, status: :active },
  { employee_id: "EMP-010", first_name: "Putri", last_name: "Amelia", email: "putri.amelia@perusahaan.com", phone: "081234567899", department: "HR", position: "Recruiter", hire_date: "2022-08-15", salary: 9000000, status: :active },
  { employee_id: "EMP-011", first_name: "Hendra", last_name: "Wijaya", email: "hendra.wijaya@perusahaan.com", phone: "081234567800", department: "Finance", position: "Finance Manager", hire_date: "2017-05-20", salary: 22000000, status: :active },
  { employee_id: "EMP-012", first_name: "Dewi", last_name: "Rahayu", email: "dewi.rahayu@perusahaan.com", phone: "081234567801", department: "Marketing", position: "Content Writer", hire_date: "2023-01-10", salary: 7000000, status: :active },
  { employee_id: "EMP-013", first_name: "Eko", last_name: "Saputra", email: "eko.saputra@perusahaan.com", phone: "081234567802", department: "IT", position: "QA Engineer", hire_date: "2021-09-05", salary: 11000000, status: :inactive },
  { employee_id: "EMP-014", first_name: "Ani", last_name: "Lestari", email: "ani.lestari@perusahaan.com", phone: "081234567803", department: "Legal", position: "Legal Advisor", hire_date: "2020-03-15", salary: 17000000, status: :active },
  { employee_id: "EMP-015", first_name: "Bambang", last_name: "Suryadi", email: "bambang.suryadi@perusahaan.com", phone: "081234567804", department: "Operations", position: "Warehouse Manager", hire_date: "2019-07-01", salary: 13000000, status: :on_leave }
]

employees = employees_data.map do |data|
  Employee.find_or_create_by!(employee_id: data[:employee_id]) do |e|
    e.assign_attributes(data)
  end
end

puts "  ✅ #{Employee.count} karyawan"

# Create leaves
leaves_data = [
  { employee: employees[0], leave_type: :annual, start_date: Date.current + 7, end_date: Date.current + 9, reason: "Liburan keluarga", status: :pending },
  { employee: employees[1], leave_type: :sick, start_date: Date.current - 3, end_date: Date.current - 2, reason: "Demam dan flu", status: :approved, approved_by: "Admin" },
  { employee: employees[2], leave_type: :personal, start_date: Date.current + 14, end_date: Date.current + 14, reason: "Urusan pribadi", status: :pending },
  { employee: employees[3], leave_type: :annual, start_date: Date.current - 10, end_date: Date.current - 6, reason: "Cuti tahunan", status: :approved, approved_by: "Admin" },
  { employee: employees[4], leave_type: :sick, start_date: Date.current - 1, end_date: Date.current, reason: "Sakit perut", status: :pending },
  { employee: employees[5], leave_type: :maternity, start_date: Date.current + 30, end_date: Date.current + 120, reason: "Cuti melahirkan", status: :approved, approved_by: "Admin" },
  { employee: employees[6], leave_type: :personal, start_date: Date.current + 3, end_date: Date.current + 3, reason: "Acara keluarga", status: :rejected, approved_by: "Admin" },
  { employee: employees[7], leave_type: :annual, start_date: Date.current + 20, end_date: Date.current + 24, reason: "Traveling", status: :pending },
  { employee: employees[14], leave_type: :unpaid, start_date: Date.current - 5, end_date: Date.current + 10, reason: "Urusan keluarga darurat", status: :approved, approved_by: "Admin" }
]

leaves_data.each do |data|
  Leave.find_or_create_by!(employee: data[:employee], start_date: data[:start_date]) do |l|
    l.assign_attributes(data)
  end
end

puts "  ✅ #{Leave.count} data cuti"

# Create attendances for today and past week
today = Date.current
active_employees = Employee.active

(6.downto(0)).each do |days_ago|
  date = today - days_ago
  next if date.saturday? || date.sunday?

  active_employees.each do |employee|
    statuses = [ :present, :present, :present, :present, :late, :remote ]
    status = statuses.sample

    base_hour = status == :late ? rand(9..10) : rand(7..8)
    check_in = date.to_datetime + base_hour.hours + rand(0..59).minutes
    check_out = check_in + rand(8..9).hours + rand(0..59).minutes

    Attendance.find_or_create_by!(employee: employee, date: date) do |a|
      a.status = status
      a.check_in = check_in
      a.check_out = check_out
      a.notes = status == :late ? "Terlambat karena macet" : nil
    end
  end
end

puts "  ✅ #{Attendance.count} data absensi"
puts "🎉 Seeding selesai!"
