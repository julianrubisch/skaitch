class Prediction < ApplicationRecord
  belongs_to :prompt

  def data_url
    encoded_data = Base64.strict_encode64(prediction_image)

    "data:image/png;base64,#{encoded_data}"
  end
end
