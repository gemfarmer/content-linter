# app/controllers/github_webhooks_controller.rb
class GithubWebhooksController < ActionController::Base
  include ::GithubWebhook::Processor

  # Handle push event
  def github_push(payload)
    # TODO: handle push webhook
    # Rails.logger.debug(payload.to_yaml)
    commits = payload['commits']

    commits.each do |commit|
      puts "added: #{commit['added']}"
      puts "modified: #{commit['modified']}"
    end

    client = Octokit::Client.new(access_token: Figaro.env.github_2FA_token)

    puts client.contents("gemfarmer/github_webhook", :path => "second.md")

    # where we are at:
    # just created a 2FA token to gain access to the github_webhooks repo
    # if that works, we will need to test if we can use the .contents octokit
    # method to read the file modified in the push to the github_webooks repo
    # If we can we will need to:
    # test PRs
    # create filter that flags bad files
    # create response that makes comments on repo!
    # http://octokit.github.io/octokit.rb/Octokit/Client/Contents.html#contents-instance_methodstick
  end

  # Handle create event
  def github_create(payload)
    # TODO: handle create webhook
  end

  def webhook_secret(payload)
    Figaro.env.github_webhooks_secret
  end
end
