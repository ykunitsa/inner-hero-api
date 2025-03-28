class CreateExposureSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :exposure_steps do |t|
      t.references :exposure, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :duration

      t.timestamps
    end
  end
end
