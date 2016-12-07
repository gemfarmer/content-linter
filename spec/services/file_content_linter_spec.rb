require 'rails_helper'

describe FileContentLinter do
  it 'returns offending lines in a given set of content' do
    file = "#{Rails.root}/mdlinter.yml"
    repo = 'gemfarmer/github_webhook'
    sha = '20345d0ee431c230e90c84e8ee454e74ec9bec21'

    file_contents = "18Fers are generally great people.\nThat's why 18F is a great place to work\n"

    linter_rules = {
      "config"=> [
        {"18F-er"=>{"replace"=>["18F team member", "18F staffer"], "reason"=>"'F-er' can imply profanity"}},
        {"18Fer"=>{"replace"=>["18F team member", "18F staffer"], "reason"=>"'F-er' can imply profanity"}},
        {"backend"=>{"replace"=>["back end", "back end development"]}}
      ]
    }

    expected_warning = [
      {
        word: "18Fer",
        line: 1,
        type: "replace",
        reason: "'F-er' can imply profanity",
        replace: ["18F team member", "18F staffer"],
        message: "Consider replacing `18Fer` with `18F team member` or `18F staffer`. 'F-er' can imply profanity."
      }
    ]

    allow(Octokit).to receive(:contents).with(repo, path: file, ref: sha).and_return(linter_rules)


    file_content_linter = FileContentLinter.new(
      { file_contents: file_contents, rules: linter_rules }
    )

    expect(file_content_linter.lint).to match_array expected_warning
  end

  it 'finds error for same word on multiple lines' do
    file = "#{Rails.root}/mdlinter.yml"
    repo = 'gemfarmer/github_webhook'
    sha = '20345d0ee431c230e90c84e8ee454e74ec9bec21'

    file_contents = "Working for 18F is sometimes great\nBut sometimes we repeat ourselves.\nIn those sometimes it is not so great.\nBeing an 18Fer is fun\n"

    linter_rules = {
      "config"=> [
        {"18F-er"=>{"replace"=>["18F team member", "18F staffer"], "reason"=>"'F-er' can imply profanity"}},
        {"18Fer"=>{"replace"=>["18F team member", "18F staffer"], "reason"=>"'F-er' can imply profanity"}},
        {"sometimes"=>{"replace"=>["generally"], "reason"=>"plain language"}}
      ]
    }

    expected_warning = [
      {
        word: "sometimes",
        line: 1,
        type: "replace",
        reason: "plain language",
        replace: ["generally"],
        message: "Consider replacing `sometimes` with `generally`. plain language."
      },
      {
        word: "sometimes",
        line: 2,
        type: "replace",
        reason: "plain language",
        replace: ["generally"],
        message: "Consider replacing `sometimes` with `generally`. plain language."
      },
      {
        word: "sometimes",
        line: 3,
        type: "replace",
        reason: "plain language",
        replace: ["generally"],
        message: "Consider replacing `sometimes` with `generally`. plain language."
      },
      {
        word: "18Fer",
        line: 4,
        type: "replace",
        reason: "'F-er' can imply profanity",
        replace: ["18F team member", "18F staffer"],
        message: "Consider replacing `18Fer` with `18F team member` or `18F staffer`. 'F-er' can imply profanity."
      }
    ]

    allow(Octokit).to receive(:contents).with(repo, path: file, ref: sha).and_return(linter_rules)


    file_content_linter = FileContentLinter.new(
      { file_contents: file_contents, rules: linter_rules }
    )

    expect(file_content_linter.lint).to match_array expected_warning
  end
end
