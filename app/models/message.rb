class Message < ApplicationRecord
  belongs_to :chat
  validates :role, inclusion: { in: %w[user assistant system] }
  validates :content, presence: true
  has_one_attached :file
end
