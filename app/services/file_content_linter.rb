require 'pry'

class FileContentLinter
	attr_accessor :file_contents, :violating_words

	def initialize(options = {})
		violating_words = ['seme word'].freeze
		# binding.pry
		@file_contents = options[:file_contents]
		@violating_words = options[:violating_words].freeze || violating_words
		# @offending_lines
	end

	def lint
    content_errors = []
    contents_array = @file_contents.split('\n')
		@violating_words.each do | word |
			contents_array.each do | line |
				puts "found: #{word}" if line =~ /#{word}/
				content_errors << { word: word, line: 0 } if line =~ /#{word}/
			end
		end
		content_errors
	end

	def lint_line
	end

	private

	attr_reader :file_contents, :violating_words
end
