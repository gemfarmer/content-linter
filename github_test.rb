require "octokit"
require "figaro"

github_username = Figaro.env.github_username
client = Octokit::Client.new(login: Figaro.env.github_username, password: Figaro.env.github_password)

repo = "#{github_username}/github_webhook"
callback_url = "http://ftwfdnfjqp.localtunnel.me/github_webhooks"
webhook_secret = "test-secret"  # Must be set after that in ENV['GITHUB_WEBHOOK_SECRET']

# Create the WebHook
client.subscribe "https://github.com/#{repo}/events/push.json", callback_url, webhook_secret
