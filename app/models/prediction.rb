class Prediction < ApplicationRecord
  include ActionView::RecordIdentifier

  after_create_commit -> { broadcast_append_later_to :predictions, target: dom_id(prompt, :predictions) }
  after_update_commit -> { broadcast_replace_later_to self }

  belongs_to :prompt

  def data_url
    encoded_data = Base64.strict_encode64(prediction_image)

    "data:image/png;base64,#{encoded_data}"
  end
end
