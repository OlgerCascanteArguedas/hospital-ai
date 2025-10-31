class PatientsProfile < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :nullify

  validates :gender, inclusion: { in: %w[masculino femenino otro], allow_blank: true }
  validates :age, numericality: { greater_than: 0, allow_nil: true }
  validates :height, :weight, numericality: { greater_than: 0, allow_nil: true }
end
