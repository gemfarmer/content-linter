require 'rails_helper'

describe FileContentLinter do
  context 'without using default rules' do
    it 'returns offending lines in a given set of content' do

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

    file_content_linter = FileContentLinter.new(
      { file_contents: file_contents, rules: linter_rules }
    )

    expect(file_content_linter.lint).to match_array expected_warning
    end

    it 'finds error for same word on multiple lines' do

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

      file_content_linter = FileContentLinter.new(
        { file_contents: file_contents, rules: linter_rules }
      )

      expect(file_content_linter.lint).to match_array expected_warning
    end
  end
  context 'using default rules' do
    it 'returns offending lines in a given set of content' do
      file_contents = "Working for 18F is collaborate great.\n"

      expected_warning = [
        {
          word: "collaborate",
          line: 1,
          type: "replace",
          reason: "plain language",
          replace: ["working with"],
          message: "Consider replacing `collaborate` with `working with`. plain language."
        }
      ]

      file_content_linter = FileContentLinter.new(
        { file_contents: file_contents }
      )

      expect(file_content_linter.lint).to match_array expected_warning
    end
  end
end
