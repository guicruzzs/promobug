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
end