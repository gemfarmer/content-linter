Octokit.configure do |config|
  config.login = 'gemfarmer-linter'
  config.password = Figaro.env.github_password
end
