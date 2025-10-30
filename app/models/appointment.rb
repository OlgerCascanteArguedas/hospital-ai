class Appointment < ApplicationRecord
  belongs_to :user
  validates :scheduled_at, :reason, presence: true
  validates :status, inclusion: { in: %w[pending confirmed cancelled], allow_blank: true }
  before_validation { self.status ||= 'pending' }
end
