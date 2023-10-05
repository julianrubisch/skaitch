class AddUniqueIndexToPredictions < ActiveRecord::Migration[7.0]
  def change
    add_index :predictions, :replicate_id, unique: true
  end
end
