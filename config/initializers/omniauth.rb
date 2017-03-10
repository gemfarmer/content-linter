Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Figaro.env.github_client_id, Figaro.env.github_client_secret
end


