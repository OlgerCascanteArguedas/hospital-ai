class PatientsProfile < ApplicationRecord
  belongs_to :user
  has_many :chats #pendiente por la confirmacion de OLGER

  validates :gender, inclusion: { in: %w[masculino femenino otro], allow_blank: true } #agrego estas validaciones para que el paciente pueda elegir una de esas opciones
  validates :age, numericality: { greater_than: 0, allow_nil: true } #agrego la validacion para evitar que el usuario no pueda continuar si no agrega la edad
  validates :height, :weight, numericality: { greater_than: 0, allow_nil: true } #de la misma manera agrego la validacion para evitar que el usuario pueda saltar poner su informacion de peso y estatura
end
