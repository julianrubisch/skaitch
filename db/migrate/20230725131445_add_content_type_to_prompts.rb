class AddContentTypeToPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :prompts, :content_type, :string
  end
end
