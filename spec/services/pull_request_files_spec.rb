require 'rails_helper'
require 'pry'

describe PullRequestFiles do
  it 'lists the files changed in a pull request' do
    repo = 'gemfarmer/github_webhook'
    sha = '20345d0ee431c230e90c84e8ee454e74ec9bec21'

    commit_response = COMMIT_RESPONSE

    response_body = double('Sawyer::Resource', commit_response)

    allow(Octokit).to receive(:commit).with(repo, sha).and_return(response_body)

    pull_request_files = PullRequestFiles.new(repo, sha)
    expect(pull_request_files.changed_files).to eq COMMIT_FILES
  end
end
