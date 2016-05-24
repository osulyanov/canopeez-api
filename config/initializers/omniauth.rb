Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.facebook_key,
           Rails.application.secrets.facebook_secret
  provider :linkedin, Rails.application.secrets.linkedin_key,
           Rails.application.secrets.linkedin_secret
end
