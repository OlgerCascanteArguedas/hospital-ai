class Appointment < ApplicationRecord
  belongs_to :user

  SPECIALTIES = [
    "Medicina General", "Cardiología", "Dermatología", "Pediatría",
    "Ginecología", "Traumatología", "Oftalmología", "Neurología",
    "Psiquiatría", "Urología"
  ].freeze

  validates :specialty, inclusion: { in: SPECIALTIES }
  validates :reason, presence: true
  validates :scheduled_at, :reason, presence: true
  validates :status, inclusion: { in: %w[pending confirmed cancelled], allow_blank: true }

  scope :upcoming, -> { order(scheduled_at: :asc) }
  before_validation { self.status ||= 'pending' }

  validate :within_office_hours

  private

  def within_office_hours
    return if scheduled_at.blank?

    local_time = scheduled_at.in_time_zone(Time.zone)
    hour = local_time.hour
    unless hour >= 7 && hour < 17
      errors.add(:scheduled_at, "debe ser entre 7:00 y 17:00")
    end
  end
end
