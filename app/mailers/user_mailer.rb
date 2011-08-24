class UserMailer < ActionMailer::Base
  default :from => "theTeam@iamin.com"
  
  def welcome_email(user)
    @user = user
    @url= "http://glowing-cloud-293.heroku.com/access/login"
    mail(:to => @user.email,
         :subject => "Welcome to iamin" )
  end
end
