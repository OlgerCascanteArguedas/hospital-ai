class Message < ApplicationRecord
  belongs_to :chat
  validates :role, inclusion: { in: %w[user assistant system] }
  validates :content, presence: true
end
