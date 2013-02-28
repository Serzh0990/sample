class SessionsController < ApplicationController
  def new
    @title = "Sign In"
  end
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:email])
    if user.nil?
      flash.now[:error] = "Invalid email/password variable"
      @title = "Sign In"
      render 'new'
    end
  else
   sign_in user
   redirect_to user
  end
end
