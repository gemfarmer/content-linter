require 'pry'
require 'rb-readline'


violating_words = [ '18Fers', 'US Government', 'enhance' , 'Update again', 'open a review', 'make sense to me'].freeze

# File.open("test.md").each do | line |
# 	violating_words.each do | word |
# 		puts "found: #{word}" if line =~ /#{word}/
# 	end
# end



def begins_with(string, chars)
	string[0..(chars.length - 1)] == chars
end

def find_file_path(string)
	string.slice(6, string.length)
end

def find_range(string)
	range = []
	split_string = string.split(' ')
	range << split_string[1].gsub('-', '').split(',')[0].to_i + split_string[1].gsub('-', '').split(',')[1].to_i
	range << split_string[1].gsub('-', '').split(',')[0].to_i + split_string[2].gsub('+', '').split(',')[1].to_i
end



def lint_line(string)
	string
end

def sort_diff(diff_array)
	returned_object = {}
	diff_array.map do |line, i|
		# binding.pry

		if begins_with(line, '+++ b/')
			returned_object['file_path'] = find_file_path(line)
			# binding.pry
		else
			if begins_with(line, '+')
				# lint_line(line)
				if returned_object['offending_lines']
					returned_object['offending_lines'] << line[1..line.length]
				else
					returned_object['offending_lines'] = [line[1..line.length]]
				end
				# returned_object['offending_lines'] << line[1..line.length]
				# binding.pry
			end
		end

		# binding.pry
		if begins_with(line, '@@')
			# binding.pry
			returned_object['line'] = {
				start: find_range(line)[0],
				end: find_range(line)[1]
			}
			# binding.pry
		end


		# binding.pry
	end
	# binding.pry

	# returned_object['offending_content'] = returned_object['offending_lines'].join("\n")

	returned_object
end

diff_url = "https://github.com/gemfarmer/github_webhook/pull/15.diff"

diff_var = `wget #{diff_url} -O -`
diff_by_files = diff_var.split('--- a/')

diffed_files = []
diff_by_files.each do |file|
	file = file.split("\n")

	diffed_files << sort_diff(file)
end

# takes array of lines
# returns array of objects
# where each object is a file with associated info that we need

diffed_files.each do | file |
	line_start = file['line'][:start]
	file['offending_lines'].each do |line|
		violating_words.each do | word |
			puts "flagged word: #{word.inspect} at line #{line_start} in #{file['file_path']}" if line =~ /#{word}/
		end
		# binding.pry
		line_start = line_start + 1
	end

end

# binding.pry
