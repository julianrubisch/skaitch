class GenerateImageJob < ApplicationJob
  include Rails.application.routes.url_helpers

  queue_as :default

  def perform(prompt:)
    model = Replicate.client.retrieve_model("stability-ai/stable-diffusion-img2img")
    version = model.latest_version
    version.predict({prompt: prompt.title, image: prompt.data_url}, replicate_rails_url(host: Rails.application.config.action_mailer.default_url_options[:host],
                                                                                        params: {sgid: prompt.to_sgid.to_s}))
  end
end
