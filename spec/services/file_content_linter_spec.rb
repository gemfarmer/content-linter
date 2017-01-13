require 'rails_helper'

describe FileContentLinter do
  context 'using default rules' do
    it 'returns offending lines in a given set of content' do
      file_contents = "Working for 18F is collaborate great.\n"

      expected_warning = [
        {
          word: 'collaborate',
          line: 1,
          type: 'replace',
          reason: 'plain language',
          replace: ['working with'],
          message: 'Consider replacing `collaborate` with `working with`. Reason: plain language.'
        }
      ]

      file_content_linter = FileContentLinter.new(
        file_contents: file_contents
      )

      expect(file_content_linter.lint).to match_array expected_warning
    end
  end
  context 'when config file is specified' do
    it 'lints the content using the specified file config' do
      file_contents = "Working for 18F is collaborate great.\n"

      expected_warning = [
        {
          word: 'collaborate',
          line: 1,
          type: 'replace',
          reason: 'plain language',
          replace: ['working with'],
          message: 'Consider replacing `collaborate` with `working with`. Reason: plain language.'
        }
      ]

      file_content_linter = FileContentLinter.new(
        file_contents: file_contents, file: "#{Rails.root}/spec/support/dummy_mdlinter.json"
      )

      expect(file_content_linter.lint).to match_array expected_warning
    end

    it 'finds error for same word on multiple lines' do
      file_contents = "There is a dropdown that some 18F team members work working on.\n" \
                      "The dropdown is in the USWDS.\n"

      expected_warning = [
        {
          word: 'dropdown',
          line: 1,
          type: 'replace',
          replace: ['drop-down menu', 'drop down'],
          message: 'Consider replacing `dropdown` with `drop-down menu` or `drop down`.'
        },
        {
          word: 'dropdown',
          line: 2,
          type: 'replace',
          replace: ['drop-down menu', 'drop down'],
          message: 'Consider replacing `dropdown` with `drop-down menu` or `drop down`.'
        }
      ]

      file_content_linter = FileContentLinter.new(
        file_contents: file_contents, file: "#{Rails.root}/spec/support/dummy_mdlinter.json"
      )
      expect(file_content_linter.lint).to match_array expected_warning
    end

    it 'finds error with many replacements, but no reason' do
      file_contents = 'Things have been crazy recently!'

      expected_warning = [
        {
          word: 'crazy',
          line: 1,
          type: 'replace',
          replace: %w(chaotic unusual complex incredible),
          message: 'Consider replacing `crazy` with `chaotic`, `unusual`, `complex`,' \
                   ' or `incredible`.'
        }
      ]

      file_content_linter = FileContentLinter.new(
        file_contents: file_contents, file: "#{Rails.root}/spec/support/dummy_mdlinter.json"
      )
      expect(file_content_linter.lint).to match_array expected_warning
    end

    it 'finds error with many replacements and a reason' do
      file_contents = 'There are only a handful of people doing frontend at 18F.'

      expected_warning = [
        {
          word: 'frontend',
          line: 1,
          type: 'replace',
          reason: 'plain language',
          replace: ['front end', 'front end development', 'front end engineering'],
          message: 'Consider replacing `frontend` with `front end`, `front end development`,' \
                   ' or `front end engineering`. Reason: plain language.'
        }
      ]

      file_content_linter = FileContentLinter.new(
        file_contents: file_contents, file: "#{Rails.root}/spec/support/dummy_mdlinter.json"
      )
      expect(file_content_linter.lint).to match_array expected_warning
    end
  end
end
