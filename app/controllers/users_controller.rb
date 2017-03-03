class UsersController < ApplicationController
  def show

  end

  # def create
  #   if user.new_record?
  #     sign_in_user
  #     redirect_to sign_up_path
  #   else
  #     sign_in_user
  #     redirect_back_or_root_path
  #   end
  # end

  # private

  # def sign_in_user
  #   @_sign_in_user ||= SignInUser.new(
  #     auth_hash: auth_hash,
  #     session: session
  #   ).perform
  # end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    # self.current_user = @user
    session[:user] = @user.id
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
