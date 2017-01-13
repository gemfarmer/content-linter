require 'octokit'
require 'pry'
require 'rb-readline'
# app/controllers/github_webhooks_controller.rb
class GithubWebhooksController < ActionController::Base
  include ::GithubWebhook::Processor

  # Handle push event
  def github_push(payload)
    # TODO: handle push webhook
    # Rails.logger.debug(payload.to_yaml)
    # commits = payload['commits']

    # commits.each do |commit|
    #   puts "added: #{commit['added']}"
    #   puts "modified: #{commit['modified']}"
    # end
    # client = Octokit::Client.new(login: 'gemfarmer-linter', password: Figaro.env.github_password)
    # client = Octokit::Client.new(access_token: Figaro.env.github_2FA_token)

    # client.create_pull_request_comment(
    #   "gemfarmer/github_webhook",
    #   1,
    #   "error on this line",
    #   "2804e029a6e3fcd55dd5acc430a8a280d8c013cb",
    #   "second.md",
    #   3
    # )

    # figure out what the commit hash is that we need to leave the comment on

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

  def github_pull_request(payload)
    @payload = payload

    files_changed.each do |file|
      content_errors = file_content_linter(file).lint

      next if content_errors.empty?
      content_errors.each do |error|
        create_pull_request_comment(error[:message], file[:filename], error[:line])
      end
    end

    # Content blob:
    # https://api.github.com/repos/gemfarmer/github_webhook/contents/second.md?ref=master
    # Github event types:
    # https://developer.github.com/v3/activity/events/types/#pullrequestevent
    # Pull Requests:
    # http://www.rubydoc.info/github/pengwynn/octokit/Octokit/Client/PullRequests:create_pull_request_comment
    # Octokit source:
    # https://github.com/octokit/octokit.rb/blob/master/lib/octokit/client/pull_requests.rb
  end

  def file_contents_for(file)
    GithubFileContents.new(repo_name, file[:filename], last_commit).file_content
  end

  def content_linter_options(file)
    { file_contents: file_contents_for(file) }
  end

  def file_content_linter(file)
    FileContentLinter.new(content_linter_options(file))
  end

  def repo_name
    @payload['pull_request']['head']['repo']['full_name']
  end

  def pull_request_number
    @payload['pull_request']['number']
  end

  def last_commit
    @payload['pull_request']['head']['sha']
  end

  def files_changed
    PullRequestFiles.new(repo_name, last_commit).changed_files
  end

  def create_pull_request_comment(error_message, filename, line)
    Octokit.create_pull_request_comment(
      repo_name,
      pull_request_number,
      error_message,
      last_commit,
      filename,
      line
    )
  end

  def github_pull_request_review_comment(payload); end

  # Handle create event
  def github_create(payload)
    # TODO: handle create webhook
  end

  def webhook_secret(_payload)
    Figaro.env.github_webhooks_secret
  end
end
