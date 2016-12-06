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

    # client.create_pull_request_comment("gemfarmer/github_webhook", 1, "error on this line", "2804e029a6e3fcd55dd5acc430a8a280d8c013cb", "second.md", 3)

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
    puts 'pull request received'
    repo_name = payload['pull_request']['head']['repo']['full_name']
    pull_request_number = payload['pull_request']['number']
    last_commit = payload['pull_request']['head']['sha']
    diff_url = payload['pull_request']['diff_url']

    files_changed = PullRequestFiles.new(repo_name, last_commit).changed_files

    num_files_changed = files_changed.length
    first_file = files_changed.first['filename']

    files_changed.each do |file|
      file_contents = GithubFileContents.new(repo_name, file[:filename], last_commit).file_content

      file_content_linter = FileContentLinter.new({file_contents: file_contents})

      content_errors = file_content_linter.lint

      content_errors.each do |error|
        error_message = "error in #{file[:filename]} for commit #{last_commit} for #{error[:word]}"
        line = error[:word]

        Octokit.create_pull_request_comment(
          repo_name,
          pull_request_number,
          error_message,
          last_commit,
          file[:filename],
          line
        )
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



  def github_pull_request_review_comment(payload)

  end

  # Handle create event
  def github_create(payload)
    # TODO: handle create webhook
  end

  def find_lines(diff)
    response = {}
    cleaned = diff.gsub("+", '').gsub('-', '').split(' ')
    response = {
      removed: {
        from: cleaned[0].split(',')[0],
        to: cleaned[0].split(',')[1]
      },
      added: {
        from: cleaned[1].split(',')[0],
        to: cleaned[1].split(',')[1]
      }
    }
  end

  def extract_lines(patch)
    response = {}
    new_lines = []
    lines = patch.split('@@')
    lines = lines.slice(1, lines.length)
    lines[0] = lines[0].strip
    lines[1] = lines[1].strip
    lines.each {|line| new_lines << line.split(/\r?\n/)}
    new_lines = new_lines.flatten
    response = find_lines(new_lines[0])
    # response['diff']
  end

  def webhook_secret(payload)
    Figaro.env.github_webhooks_secret
  end
end


