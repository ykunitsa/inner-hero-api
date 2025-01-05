class CreateSituations < ActiveRecord::Migration[8.0]
  def change
    create_table :situations do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
