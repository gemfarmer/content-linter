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
        specs_type = specs[type]
        if specs_type
          warning_response[type.to_sym] = specs_type
          warning_response[:type] = type
        end
      end

      if specs['reason']
        warning_response[:reason] = specs['reason']
      end

      @content_warnings << warning_response if !warning_response.empty?
    end
  end

  private

  attr_reader :file_contents, :rules
end
