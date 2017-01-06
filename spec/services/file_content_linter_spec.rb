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
          message: 'Consider replacing `collaborate` with `working with`. plain language.'
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
          message: 'Consider replacing `collaborate` with `working with`. plain language.'
        }
      ]

      file_content_linter = FileContentLinter.new(
        file_contents: file_contents, file: "#{Rails.root}/spec/support/dummy_mdlinter.json"
      )

      expect(file_content_linter.lint).to match_array expected_warning
    end

    it 'finds error for same word on multiple lines' do
      file_contents = "There is a dropdown that some 18F team members work working on.\nThe dropdown is in the USWDS.\n"

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
  end
end
