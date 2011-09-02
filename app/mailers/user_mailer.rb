class UserMailer < ActionMailer::Base
  default :from => "theTeam@joinerous.com"
  
  def welcome_email(user)
    @user = user
    email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    @url= "http://joinerous.com/access/login"
    mail(:to => email_with_name,
         :subject => "Welcome to Joinerous" )
  end
  
  def user_is_in_email(user, event)
    @event = event
    @planner = User.find_by_email(@event.event_planner)
    planner_email_with_name = "#{@planner.first_name} #{@planner.last_name} <#{@planner.email}>"
    @user = user
    user_email_with_name = "#{@user.first_name} #{@user.last_name} <#{@user.email}>"
    @event_url = "http://joinerous.com/events/#{event.id}"
    mail( :from => user_email_with_name,
          :to => planner_email_with_name,
          :subject => "#{@user.first_name} #{@user.last_name} is in!")
  end
  
end
