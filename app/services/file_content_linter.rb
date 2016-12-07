require 'pry'
require 'yaml'

class FileContentLinter
  attr_accessor :file_contents, :rules

  def initialize(options = {})
    if options[:rules]
      @rules = options[:rules].freeze
    else
      @rules = YAML.load_file('mdlinter.yml').freeze
    end
    @file_contents = options[:file_contents]
    @content_warnings = []
    @warning_types = [
      "replace"
    ]
    @haha = []

  end

  def lint
    if @rules['config']
      @rules['config'].each do | rule |
        @file_contents.split("\n").each_with_index do | line, index |
          check_rule(rule, line, index)
        end
      end
    end
    @content_warnings
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

      @content_warnings << warning_response if !warning_response.empty?
    end
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
    # binding.pry
  end

  private

  attr_reader :file_contents, :rules
end
