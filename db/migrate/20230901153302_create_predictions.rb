class CreatePredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :predictions do |t|
      t.references :prompt, null: false, foreign_key: true
      t.string :replicate_id
      t.string :replicate_version
      t.binary :prediction_image
      t.text :logs

      t.timestamps
    end
  end
end
