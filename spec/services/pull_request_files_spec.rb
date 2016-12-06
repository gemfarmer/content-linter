require 'rails_helper'
require 'pry'

describe PullRequestFiles do
  it 'lists the files changed in a pull request' do
    commit_files = "#{Rails.root}/spec/support/commit_files.rb"
    repo = 'gemfarmer/github_webhook'
    sha = '20345d0ee431c230e90c84e8ee454e74ec9bec21'


    commit_response = eval(File.read("#{Rails.root}/spec/support/commit_response.rb"))

    response_body = double("Sawyer::Resource", commit_response)

    allow(Octokit).to receive(:commit).with(repo, sha).and_return(response_body)

    pull_request_files = PullRequestFiles.new(repo, sha)
    expect(pull_request_files.changed_files).to eq eval(File.read(commit_files))
  end
end
