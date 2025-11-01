class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :patients_profile, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :analyses, dependent: :destroy

  after_create :ensure_profile!

  private
  def ensure_profile!
    create_patients_profile! unless patients_profile
  end
end
