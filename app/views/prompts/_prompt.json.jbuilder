json.extract! prompt, :id, :title, :description, :prompt_image, :account_id, :created_at, :updated_at
json.url prompt_url(prompt, format: :json)
json.description prompt.description.to_s
