Octokit.configure do |config|
  config.access_token = Figaro.env.github_access_token
end
