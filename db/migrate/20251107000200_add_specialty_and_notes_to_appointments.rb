class AddSpecialtyAndNotesToAppointments < ActiveRecord::Migration[7.1]
  def change
    add_column :appointments, :specialty, :string
    add_column :appointments, :notes, :text
  end
end
