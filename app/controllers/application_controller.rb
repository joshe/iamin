class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # redirect somewhere that will eventually return back to here
  def redirect_away(*params)
    session[:original_uri] = request.request_uri
    redirect_to(*params)
  end

  # returns the person to either the original url from a redirect_away or to a default url
  def redirect_back(*params)
    uri = session[:original_uri]
    session[:original_uri] = nil
    if uri
      redirect_to uri
    else
      redirect_to(*params)
    end
  end
  
  protected 
  
  def confirm_logged_in
     unless session[:user_id]
       flash[:message] = "Please log in."
       redirect_away(:controller => "access", :action => "login")
       return false # halts the before_filter
     else
       @u = User.find(session[:user_id])
       return true
     end
   end
   
end
