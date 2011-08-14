class AccessController < ApplicationController
  
  before_filter :confirm_logged_in, :except => [:login, :attempt_login, :logout]
  
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
    @incomingController = params[:controller]
    @incomingAction = params[:action]
    
    authorized_user = User.authenticate(params[:email], params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:email] = authorized_user.email
      redirect_back(:action => 'index')
    else
      flash[:message] = "Invalid username/password combination"
      redirect_to :action => 'login'
    end
  end
  
  def logout
    session[:user_id] = nil
    session[:email] = nil
    flash[:message] = "You have been logged out."
    redirect_to :action => "login"
  end

end