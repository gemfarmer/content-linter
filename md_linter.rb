violating_words = [ '18Fers', 'US Government' ].freeze

File.open("test.md").each do | line |
	violating_words.each do | word |
		puts "found: #{word}" if line =~ /#{word}/
	end
end
