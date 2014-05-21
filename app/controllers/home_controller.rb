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
    params[:code] = "4/xFFAIBgAvECxDXXaAkT_gkyNX4G3.4hZapKjE_sAS3oEBd8DOtNDjfv1AjAI"

    user = User.get_user(params[:code])
    redirect_to :controller=>'devise/sessions', :action=>'new', :email=>user.email, :password=>User.generate_pass(user.email), :layout=>"redirection"
  end
  
  def list_google_agendas
  	@data_response = GoogleCalendar.list_agendas(token_access)
  end

  def check_new_offers
    success = false
    if params[:release_code] == RELEASE_CODE
      success = true
      Offer.verify
    end
    render :json=>{:authenticated=>success, :runned=>success}
  end
end