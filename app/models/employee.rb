class Employee < ApplicationRecord
  has_many :leaves, dependent: :destroy
  has_many :attendances, dependent: :destroy

  enum :status, { active: 0, inactive: 1, on_leave: 2, terminated: 3 }

  validates :employee_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :department, presence: true
  validates :position, presence: true
  validates :hire_date, presence: true
  validates :salary, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  after_create_commit { Activity.log(action: "employee_created", trackable: self, description: "Karyawan baru ditambahkan: #{full_name}") }
  after_update_commit { Activity.log(action: "employee_updated", trackable: self, description: "Data karyawan diperbarui: #{full_name}") }

  scope :by_department, ->(dept) { where(department: dept) if dept.present? }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :recent, -> { order(created_at: :desc) }
  scope :search, ->(query) {
    where("first_name LIKE :q OR last_name LIKE :q OR email LIKE :q OR employee_id LIKE :q", q: "%#{query}%") if query.present?
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  def initials
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  def years_of_service
    return 0 unless hire_date
    ((Date.current - hire_date).to_f / 365.25).floor
  end

  def total_leaves_this_year
    leaves.where("start_date >= ?", Date.current.beginning_of_year).where(status: [:approved, :pending]).sum(:days_count)
  end

  def leave_balance
    (leave_quota || 12) - total_leaves_this_year
  end

  def leave_usage_percent
    quota = leave_quota || 12
    return 0 if quota.zero?
    [(total_leaves_this_year.to_f / quota * 100).round, 100].min
  end

  def attendance_rate_this_month
    total_days = attendances.where(date: Date.current.beginning_of_month..Date.current).count
    present_days = attendances.where(date: Date.current.beginning_of_month..Date.current, status: :present).count
    return 0 if total_days.zero?
    ((present_days.to_f / total_days) * 100).round(1)
  end
end
