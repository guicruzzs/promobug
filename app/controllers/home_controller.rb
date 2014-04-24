class HomeController < ApplicationController
  def index
    if user_signed_in? 
      session[:access_token] = current_user.access_token
      @recent_offers = Offer.all(:order=>"created_at DESC", :limit=>5)
    end
  end

  def google_login
  	@login_content = GoogleApi.login
    render :layout=>"redirection"
  end

  def google_login_response
    # params[:code] = "4/SzDxl0IafDhf8oFEoiaNiVwPhKAW.klC7nH-45awY3oEBd8DOtNC15ggkiwI"

    user = User.get_user(params[:code])
    redirect_to :controller=>'devise/sessions', :action=>'new', :email=>user.email, :password=>User.generate_pass(user.email), :layout=>"redirection"
  end
  
  def list_google_agendas
  	@data_response = GoogleCalendar.list_agendas(token_access)
  end

end