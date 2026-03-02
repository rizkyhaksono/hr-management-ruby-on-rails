class Activity < ApplicationRecord
  belongs_to :trackable, polymorphic: true, optional: true

  validates :action, presence: true
  validates :description, presence: true

  scope :recent, -> { order(created_at: :desc) }

  ICONS = {
    "employee_created" => "users",
    "employee_updated" => "pencil",
    "employee_deleted" => "trash",
    "leave_created" => "calendar",
    "leave_approved" => "check_circle",
    "leave_rejected" => "x_circle",
    "attendance_created" => "clock",
    "attendance_bulk" => "clock"
  }.freeze

  DOT_CLASSES = {
    "employee_created" => "success",
    "leave_approved" => "success",
    "leave_rejected" => "danger",
    "leave_created" => "warning"
  }.freeze

  def icon_name
    ICONS[action] || "activity"
  end

  def dot_class
    DOT_CLASSES[action] || ""
  end

  def self.log(action:, trackable: nil, description:)
    create!(
      action: action,
      trackable: trackable,
      description: description
    )
  end
end
