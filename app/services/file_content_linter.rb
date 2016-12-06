require 'pry'

class FileContentLinter
  attr_accessor :file_contents, :violating_words

  def initialize(options = {})
    violating_words = ['seme word'].freeze
    @file_contents = options[:file_contents]
    @violating_words = options[:violating_words].freeze || violating_words
  end

  def lint
    content_errors = []
    contents_array = @file_contents.split("\n")
    @violating_words.each do | word |
      contents_array.each_with_index do | line, index |
        puts "line: #{line}"
        puts "found word: #{word} on line #{index + 1}" if line =~ /#{word}/

        content_errors << { word: word, line: (index + 1) } if line =~ /#{word}/
      end
    end
    content_errors
  end

  private

  attr_reader :file_contents, :violating_words
end
