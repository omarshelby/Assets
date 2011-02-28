class UsersController < ApplicationController
  def new
    @users = Users.new
  end

  def create
    @users = Users.new(params[:users])
    if @users.save
      session[:users_id] = @users.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
