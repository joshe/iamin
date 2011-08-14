class AccessController < ApplicationController
  
  def index
    menu
    render 'menu' 
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