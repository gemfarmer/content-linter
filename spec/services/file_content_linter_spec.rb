require 'rails_helper'

describe FileContentLinter do
  it 'returns offending lines in a given set of content' do
    file_contents = "start new file\nmore text here\neven more\nand more\n...\n"

    violating_words = ['start', 'new file']

    expected_error = [
      {
        word: "start",
        line: 0
      },
      {
        word: "new file",
        line: 0
      }
    ]

    file_content_linter = FileContentLinter.new(
      { file_contents: file_contents, violating_words: violating_words }
    )

    expect(file_content_linter.lint).to eq expected_error
  end
end
