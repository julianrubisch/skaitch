class Prompt < ApplicationRecord
  include AccountScoped

  belongs_to :account
  has_rich_text :description

  validates :title, :prompt_image, :content_type, presence: true

  def data_url
    encoded_data = Base64.strict_encode64(prompt_image)

    "data:image/#{content_type};base64,#{encoded_data}"
  end
end
