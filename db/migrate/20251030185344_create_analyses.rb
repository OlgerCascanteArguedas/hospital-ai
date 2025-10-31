class CreateAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :analyses do |t|
      t.string :description
      t.text :ai_result
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
