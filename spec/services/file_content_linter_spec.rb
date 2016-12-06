require 'rails_helper'

describe FileContentLinter do
  it 'returns offending lines in a given set of content' do
    file_contents = "start new file\nmore text here\neven more\nand more\n...\n"

    violating_words = ['start', 'new file', 'and']
    violating_words_2 = ['more']

    expected_error = [
      {
        word: "start",
        line: 1
      },
      {
        word: "new file",
        line: 1
      },
      {
        word: "and",
        line: 4
      }
    ]

    file_content_linter = FileContentLinter.new(
      { file_contents: file_contents, violating_words: violating_words }
    )

    expect(file_content_linter.lint).to eq expected_error
  end

  it 'finds error for same word on multiple ilnes' do
    file_contents = "start new file\nmore text here\neven more\nand more\n...\n"

    violating_words = ['more']

    expected_error = [
      {
        word: "more",
        line: 2
      },
      {
        word: "more",
        line: 3
      },
      {
        word: "more",
        line: 4
      }
    ]

    file_content_linter = FileContentLinter.new(
      { file_contents: file_contents, violating_words: violating_words }
    )

    expect(file_content_linter.lint).to eq expected_error
  end
end
