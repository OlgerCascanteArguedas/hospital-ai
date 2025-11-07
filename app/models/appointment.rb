class Appointment < ApplicationRecord
  belongs_to :user

  SPECIALTIES = [
    "Medicina General", "Cardiología", "Dermatología", "Pediatría",
    "Ginecología", "Traumatología", "Oftalmología", "Neurología",
    "Psiquiatría", "Urología"
  ].freeze

  validates :specialty, inclusion: { in: SPECIALTIES }
  validates :reason, presence: true
  validates :scheduled_at, presence: true

  scope :upcoming, -> { order(scheduled_at: :asc) }
end
