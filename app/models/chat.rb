class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :patients_profile
  has_many :messages, dependent: :destroy

  validates :title, presence: true
end
