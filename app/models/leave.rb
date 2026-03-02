class Leave < ApplicationRecord
  belongs_to :employee

  enum :leave_type, { annual: 0, sick: 1, personal: 2, maternity: 3, paternity: 4, unpaid: 5 }
  enum :status, { pending: 0, approved: 1, rejected: 2, cancelled: 3 }

  validates :leave_type, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :reason, presence: true
  validate :end_date_after_start_date
  validate :no_overlapping_leaves

  before_save :calculate_days_count
  after_create_commit { Activity.log(action: "leave_created", trackable: self, description: "#{employee.full_name} mengajukan cuti #{leave_type.humanize}") }

  scope :recent, -> { order(created_at: :desc) }
  scope :this_year, -> { where("start_date >= ?", Date.current.beginning_of_year) }
  scope :by_status, ->(status) { where(status: status) if status.present? }
  scope :by_type, ->(leave_type) { where(leave_type: leave_type) if leave_type.present? }

  def duration_text
    if days_count == 1
      "1 hari"
    else
      "#{days_count} hari"
    end
  end

  private

  def calculate_days_count
    return unless start_date && end_date
    self.days_count = (end_date - start_date).to_i + 1
  end

  def end_date_after_start_date
    return unless start_date && end_date
    if end_date < start_date
      errors.add(:end_date, "harus setelah tanggal mulai")
    end
  end

  def no_overlapping_leaves
    return unless employee && start_date && end_date
    overlapping = employee.leaves
      .where.not(id: id)
      .where.not(status: :cancelled)
      .where("start_date <= ? AND end_date >= ?", end_date, start_date)
    if overlapping.exists?
      errors.add(:base, "Sudah ada cuti yang tumpang tindih pada tanggal tersebut")
    end
  end
end
