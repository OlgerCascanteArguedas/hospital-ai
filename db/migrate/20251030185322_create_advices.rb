class CreateAdvices < ActiveRecord::Migration[7.1]
  def change
    create_table :advices do |t|
      t.string :specialty
      t.string :consult_type
      t.string :medicine_type

      t.timestamps
    end
  end
end
