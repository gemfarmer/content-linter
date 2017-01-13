require 'octokit'
require 'figaro'

github_username = Figaro.env.github_username
client = Octokit::Client.new(
  login: Figaro.env.github_username,
  password: Figaro.env.github_password
)

repo = "#{github_username}/github_webhook"
# Must be set after that in ENV['GITHUB_WEBHOOK_SECRET']
webhook_secret = Figaro.env.github_webhooks_secret

# Create the WebHook
client.subscribe(
  "https://github.com/#{repo}/events/push.json",
  callback_url,
  webhook_secret
)
