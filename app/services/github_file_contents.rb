class GithubFileContents
	def initialize(repo, filename, sha)
		@filename = filename
		@repo = repo
		@sha = sha
	end

	def file_content
		contents = Octokit.contents(repo, path: filename, ref: sha)
		Base64.decode64(contents.content).force_encoding("UTF-8")
	end

	private

	attr_reader :filename, :repo, :sha
end
