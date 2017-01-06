require 'rails_helper'

describe GithubFileContents do
  it 'returns the contents of the file' do
    file = "#{Rails.root}/spec/support/test.md"
    repo = 'gemfarmer/github_webhook'
    sha = '20345d0ee431c230e90c84e8ee454e74ec9bec21'

    contents_response = {
      name: 'second.md',
      path: 'second.md',
      sha: 'b2ac6162d16f4c66edaa08493c2a0b29451b4d4b',
      size: 286,
      url:       'https://api.github.com/repos/gemfarmer/github_webhook/contents/second.md?ref=20345d0ee431c230e90c84e8ee454e74ec9bec21',
      html_url:       'https://github.com/gemfarmer/github_webhook/blob/20345d0ee431c230e90c84e8ee454e74ec9bec21/second.md',
      git_url:       'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs/b2ac6162d16f4c66edaa08493c2a0b29451b4d4b',
      download_url:       'https://raw.githubusercontent.com/gemfarmer/github_webhook/20345d0ee431c230e90c84e8ee454e74ec9bec21/second.md',
      type: 'file',
      content: Base64.encode64(File.read(file)),
      encoding: 'base64',
      _links: {
        self:         'https://api.github.com/repos/gemfarmer/github_webhook/contents/second.md?ref=20345d0ee431c230e90c84e8ee454e74ec9bec21',
        git:         'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs/b2ac6162d16f4c66edaa08493c2a0b29451b4d4b',
        html:         'https://github.com/gemfarmer/github_webhook/blob/20345d0ee431c230e90c84e8ee454e74ec9bec21/second.md'
      }
    }

    response_body = double('Sawyer::Resource', contents_response)

    allow(Octokit).to receive(:contents).with(repo, path: file, ref: sha).and_return(response_body)

    github_file_contents = GithubFileContents.new(repo, file, sha)

    expect(github_file_contents.file_content).to eq File.read(file)
  end
end
