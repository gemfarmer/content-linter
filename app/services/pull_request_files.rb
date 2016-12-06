require 'pry'

class PullRequestFiles
	def initialize(repo_name, last_commit)
		@repo_name = repo_name
		@last_commit = last_commit
	end

	def changed_files
		Octokit.commit(repo_name, last_commit).files
	end

	private

	attr_reader :repo_name, :last_commit
end
