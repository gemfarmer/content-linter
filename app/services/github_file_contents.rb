class GithubFileContents
	def initialize(repo, filename, sha)
		@filename = filename
		@repo = repo
		@sha = sha
	end

	def file_content
		begin
			contents = Octokit.contents(@repo, path: @filename, ref: @sha)
		rescue
			puts "Error: Could not get contents for #{@filename} from GitHub"
		else
			Base64.decode64(contents.content).force_encoding("UTF-8")
		end
	end

	private

	attr_reader :filename, :repo, :sha
end
