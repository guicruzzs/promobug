class AgendasController < ApplicationController
  before_filter :load_google_agendas, :only=>[:new, :create]
  # GET /agendas
  # GET /agendas.xml
  def index
    @agendas = Agenda.where(:user_id=>current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendas }
    end
  end

  # GET /agendas/1
  # GET /agendas/1.xml
  def show
    @agenda = Agenda.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agenda }
    end
  end

  # GET /agendas/new
  # GET /agendas/new.xml
  def new
    @agenda = Agenda.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /agendas/1/edit
  def edit
    @agenda = Agenda.find(params[:id])
  end

  # POST /agendas
  # POST /agendas.xml
  def create
    puts "-------- params"
    puts params.inspect
    @agenda = Agenda.new(params[:agenda])
    puts "--------  agenda"
    respond_to do |format|
      if @agenda.save
        @agenda.inactivate_the_old
        format.html { redirect_to({:action=>"index"}, :notice => 'Agenda was successfully created.') }
      else
        @data_response = GoogleCalendar.list_agendas(session[:access_token])
        puts @agenda.inspect
        @agenda.clear_to_form
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /agendas/1
  # PUT /agendas/1.xml
  def update
    @agenda = Agenda.find(params[:id])

    respond_to do |format|
      if @agenda.update_attributes(params[:agenda])
        format.html { redirect_to(@agenda, :notice => 'Agenda was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agenda.errors, :status => :unprocessable_entity }
      end
    end
  end

  def inactivate
    user = current_user
    agenda = Agenda.where(:id=>params[:id]).first
    respond_to do |format|
      if !agenda.nil? and (user.id == agenda.user_id)
        agenda.inactivate
        puts "SUCCESS"
        format.html { redirect_to({:controller=>"agendas", :action=>"index"}, :notice => 'Filtro desativado com sucesso!')}
      else
        puts "FAIL"
        format.html { redirect_to({:controller=>"agendas", :action=>"index"}, :notice => 'Não foi possível desativar esse filtro!')}
      end
    end
  end
  # DELETE /agendas/1
  # DELETE /agendas/1.xml
  def destroy
    @agenda = Agenda.find(params[:id])
    @agenda.destroy

    respond_to do |format|
      format.html { redirect_to(agendas_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_google_agendas
    puts "------ ooooooooooooooooo"
    current_user.check_token_expiration
    @data_response = GoogleCalendar.list_agendas(current_user.access_token)
  end
end
