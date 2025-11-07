class Appointment < ApplicationRecord
  belongs_to :user

  validates :scheduled_at, :reason, presence: true
  validates :status, inclusion: { in: %w[pending confirmed cancelled], allow_blank: true }
  before_validation { self.status ||= 'pending' }

  # ⬇️ Agregar
  validate :within_office_hours

  private

  # Permitir 07:00 <= hora < 17:00 (17:00 exacto queda fuera; si querés incluirla, avisá)
  def within_office_hours
    return if scheduled_at.blank?

    local_time = scheduled_at.in_time_zone(Time.zone)
    hour = local_time.hour
    unless hour >= 7 && hour < 17
      errors.add(:scheduled_at, "debe ser entre 7:00 y 17:00")
    end
  end
end
