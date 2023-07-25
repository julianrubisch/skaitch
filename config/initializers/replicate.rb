Replicate.client.api_token = Rails.application.credentials[:replicate][:api_token]

class ReplicateWebhook
  def call(prediction)
    # binding.irb
  end
end

ReplicateRails.configure do |config|
  config.webhook_adapter = ReplicateWebhook.new
end
