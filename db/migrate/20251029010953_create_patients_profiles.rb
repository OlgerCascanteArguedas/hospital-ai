class CreatePatientsProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :patients_profiles do |t|
      t.text :allergies
      t.integer :weight
      t.integer :age
      t.text :conditions
      t.integer :height
      t.string :gender
      t.text :medication
      t.text :medical_history
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
