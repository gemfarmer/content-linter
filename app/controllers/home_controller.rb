class HomeController < ApplicationController
  def show
    @user = User.find(session[:user])

    user = Octokit.user @user.id

    @repos = user.rels[:repos].get.data
  end
end
