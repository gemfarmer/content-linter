require 'octokit'
# require 'figaro'
require 'pry'

github_username = 'gemfarmer'
# client = Octokit::Client.new(
#   login: Figaro.env.github_username,
#   password: Figaro.env.github_password
# )

client = Octokit::Client.new(
  access_token: Figaro.env.github_access_token
)

repo = "#{github_username}/github_webhook"
# Must be set after that in ENV['GITHUB_WEBHOOK_SECRET']
webhook_secret = Figaro.env.github_webhooks_secret
callback_url = 'https://content-linter.apps.cloud.gov/github_webhooks'

# Create the WebHook
client.subscribe(
  "https://github.com/#{repo}/events/push.json",
  callback_url,
  webhook_secret
)
