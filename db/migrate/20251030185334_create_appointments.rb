class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.datetime :scheduled_at
      t.string :reason
      t.string :status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
