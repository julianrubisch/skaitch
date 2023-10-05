Replicate.client.api_token = Rails.application.credentials[:replicate][:api_token]

require "open-uri"

class ReplicateWebhook
  def call(prediction)
    query = URI(prediction.webhook).query

    prediction_sgid = CGI.parse(query)["prediction"].first
    account_sgid = CGI.parse(query)["account"].first

    located_prediction = GlobalID::Locator.locate_signed(prediction_sgid)
    Current.account = GlobalID::Locator.locate_signed(account_sgid)

    located_prediction.update(
      prediction_image: URI.parse(prediction.output.first).open.read,
      replicate_id: prediction.id,
      replicate_version: prediction.version,
      logs: prediction.logs
    )
  end
end

ReplicateRails.configure do |config|
  config.webhook_adapter = ReplicateWebhook.new
end
