class Attendance < ApplicationRecord
  belongs_to :employee

  enum :status, { present: 0, absent: 1, late: 2, half_day: 3, remote: 4 }

  validates :date, presence: true
  validates :date, uniqueness: { scope: :employee_id, message: "sudah ada catatan absensi untuk tanggal ini" }
  validate :check_out_after_check_in

  after_create_commit { Activity.log(action: "attendance_created", trackable: self, description: "Absensi #{employee.full_name}: #{status.humanize}") }

  scope :recent, -> { order(date: :desc) }
  scope :today, -> { where(date: Date.current) }
  scope :this_month, -> { where(date: Date.current.beginning_of_month..Date.current.end_of_month) }
  scope :this_week, -> { where(date: Date.current.beginning_of_week..Date.current.end_of_week) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_date_range, ->(start_date, end_date) {
    where(date: start_date..end_date) if start_date.present? && end_date.present?
  }

  def working_hours
    return nil unless check_in && check_out
    ((check_out - check_in) / 1.hour).round(1)
  end

  def working_hours_text
    hours = working_hours
    return "-" unless hours
    "#{hours} jam"
  end

  private

  def check_out_after_check_in
    return unless check_in && check_out
    if check_out <= check_in
      errors.add(:check_out, "harus setelah waktu masuk")
    end
  end
end
