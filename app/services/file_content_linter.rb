require 'pry'
require 'yaml'
require 'json'

class FileContentLinter

  def initialize(options = {})
    if options[:rules]
      @rules = options[:rules].freeze
    else
      # @rules = YAML.load_file('mdlinter.yml').freeze
      file = File.read('mdlinter.json')
      @rules = JSON.parse(file).freeze
      puts "@rules: #{@rules}"
    end
    @file_contents = options[:file_contents]
    @warning_types = [
      "replace"
    ]
  end

  def lint
    content_warnings = []
    if @rules['config']
      @rules['config'].each do | rule |
        @file_contents.split("\n").each_with_index do | line, index |
          obj = check_rule(rule, line, index)
          content_warnings << obj if obj.present?
        end
      end
    end
    content_warnings
  end

  def check_rule(rule, line, index)
    warning_response = {}
    word = rule.keys[0]
    if line.downcase.include? word.downcase
      warning_response[:word] = word
      warning_response[:line] = index + 1

      specs = rule[word]

      @warning_types.each do |type|
        spec = specs[type]
        if spec
          warning_response[type.to_sym] = spec
          warning_response[:type] = type
          warning_response[:message] = format_message(word, spec, specs['reason'])
        end
      end

      if specs['reason']
        warning_response[:reason] = specs['reason']
      end
    end
    puts "warning_response: #{warning_response}"
    warning_response
  end

  def format_message(word, spec, reason = '')
    if spec.kind_of?(Array)
      replacement = spec.each_with_index.map do |s, i|
        if i == spec.length - 1
          "`#{s}`"
        elsif i == spec.length - 2
         spec.length > 2 ? "`#{s}`, or " : "`#{s}` or ";
        else
          "`#{s}`, "
        end
      end.join
    else
      replacement = spec
    end

    if reason
      "Consider replacing `#{word}` with #{replacement}. #{reason}."
    else
      "Consider replacing `#{word}` with #{replacement}."
    end
  end

  private

  attr_reader :file_contents, :rules
end
