class Agenda < ActiveRecord::Base
  belongs_to :user
  has_one :interest
  
  STATUS_ATIVO = true
  STATUS_INATIVO = false

  accepts_nested_attributes_for :interest

  validates_presence_of :google_code

  def interest_attributes=(interest_attributes)
	  build_interest(interest_attributes)
  end

  def inactivate()
  	self.status = Agenda::STATUS_INATIVO
  	self.interest.inactivate if self.save
  end

  def inactivate_the_old
    agenda = Agenda.where(:user_id=>self.user_id, :status=>Agenda::STATUS_ATIVO).first
    agenda.inactivate unless agenda.nil? or agenda.id == self.id
  end

  def clear_to_form
    interest.clear_to_form
  end

  def self.create_google_agenda(user,name)
    GoogleCalendar.create_calendar(user.access_token, name)
    # {"kind"=>"calendar#calendar", "id"=>"4i0duieojvusci5sjdisnpp0k8@group.calendar.google.com", "summary"=>"Agenda Teste", "etag"=>"\"SaH0JPgxpZtQtKmztOIhZtDaAls/hvTted6vG_-iOf99UezkJIeL0Fo\""}
  end
end