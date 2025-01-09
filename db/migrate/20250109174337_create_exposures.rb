class CreateExposures < ActiveRecord::Migration[8.0]
  def change
    create_table :exposures do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :situation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
