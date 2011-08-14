class AccessController < ApplicationController
  
  def index
    menu
    render 'menu' 
  end

  def new
	@user = User.new
  end

  def create
	@user = User.new(params[:user])
    if @user.save
	  flash[:message] = "You have successfully created your account"
      redirect_to events_path
    else
      render :action => "new"
    end
  end
  
  def menu
    #display text & links
  end

  def login
    #login form
  end
  
  def attempt_login
    authorized_user = User.authenticate(params[:username], params[:password])
    if authorized_user
      # TODO: mark user as logged in
      flash[:message] = "You are now logged in."
      redirect_to :action => 'menu'
    else
      flash[:message] = "Invalid username/password combination"
      redirect_to :action => 'login'
    end
  end
  
  def logout
    # TODO: mark user as logged out
    flash[:message] = "You have been logged out."
    redirect_to :action => "login"
  end

end