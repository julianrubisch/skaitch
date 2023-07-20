class CreateAccountsMigration < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts
  end
end
