require 'yaml'
require 'json'

class FileContentLinter
  def initialize(file_contents:, file: nil)
    file ||= 'mdlinter.json'
    file = File.read(file)
    @rules = JSON.parse(file).freeze

    ConfigValidator.new(@rules).validate

    @file_contents = file_contents
    @warning_types = [
      'replace'
    ]
  end

  def lint
    content_warnings = []
    @rules['config']&.each do |rule|
      @file_contents.split("\n").each_with_index do |line, index|
        obj = check_rule(rule, line, index)
        content_warnings << obj if obj.present?
      end
    end
    content_warnings
  end

  private

  def check_rule(rule, line, index)
    warning_response = {}
    word = rule.keys[0]
    if line.downcase.include? word.downcase
      warning_response[:word] = word
      warning_response[:line] = index + 1

      specs = rule[word]

      warning_response = check_warning_types(specs, warning_response, word)
      warning_response[:reason] = specs['reason'] if specs['reason']
    end
    warning_response
  end

  def check_warning_types(specs, warning_response, word)
    @warning_types.each do |type|
      spec = specs[type]
      next unless spec
      warning_response[type.to_sym] = spec
      warning_response[:type] = type
      warning_response[:message] = format_message(word, spec, specs['reason'])
    end
    warning_response
  end

  def format_message(word, spec, reason = '')
    replacement = [spec].flatten.map { |s| "`#{s}`" }

    sentence = replacement.to_sentence(last_word_connector: ', or ', two_words_connector: ' or ')
    result = "Consider replacing `#{word}` with #{sentence}."

    result << " Reason: #{reason}." if reason
    result
  end

  attr_reader :file_contents, :rules
end
