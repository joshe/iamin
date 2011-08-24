class UserMailer < ActionMailer::Base
  default :from => "theTeam@iamin.com"
  
  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    @url= "http://glowing-cloud-293.heroku.com/access/login"
    mail(:to => email_with_name,
         :subject => "Welcome to iamin" )
  end
end
