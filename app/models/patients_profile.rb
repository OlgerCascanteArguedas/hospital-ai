class PatientsProfile < ApplicationRecord
  belongs_to :user
  has_many :chats #pendiente por revisar dependiendo el nombre que plger utilice

  validates :gender, :age
  validates :height, :weight presence: true
  validates :allergies, :conditions, :medication allow_blank: true


end
