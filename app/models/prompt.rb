require "vips"

class Prompt < ApplicationRecord
  include AccountScoped
  include Litesearch::Model
  include Litemetric::Measurable

  belongs_to :account
  has_many :predictions, dependent: :destroy
  has_rich_text :description

  litesearch do |schema|
    schema.fields [:title]
  end

  validates :title, :prompt_image, :content_type, presence: true

  before_save :scale_prompt_image

  def data_url
    encoded_data = Base64.strict_encode64(prompt_image)

    "data:image/#{content_type};base64,#{encoded_data}"
  end

  private

  def scale_prompt_image
    measure("scale_prompt_image") do
      image = Vips::Image.new_from_buffer(prompt_image, "")
      pipeline = ImageProcessing::Vips.source(image)

      self.prompt_image = pipeline.resize_to_fit(768, 768).call.read
    end
  end
end
