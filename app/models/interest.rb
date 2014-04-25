class Interest < ActiveRecord::Base
  belongs_to :agenda
  has_many :schedules
  
  validate :fill_out_wishes
  before_save :load_regexp

  STATUS_ATIVO = true
  STATUS_INATIVO = false

  named_scope :active, :conditions=>{:status=> Interest::STATUS_ATIVO}

  def inactivate()
    self.status = Agenda::STATUS_INATIVO
    self.save
  end

  def self.test
    offer = Offer.last
    Interest.verify(offer)
    puts "FIM TESTE"
  end

  def self.verify(offer)
  	puts "INTEREST.VERIFY"
  	puts offer.inspect

    interests = Interest.active

    interests.each do |interest|
      offer.verify_interest(interest)
    end
    puts "VERIFICATION'S END"
  end

  def fill_out_wishes
    puts "FILL OUT WISHES"
    if self.wanted_regexp.blank?
      errors.add " ", "É obrigatório o preenchimento ao menos do(s) Desejado(s)"
    end
  end

  def load_regexp
    puts "LOAD REGEXP"
  	if self.status == Interest::STATUS_ATIVO
      self.wanted = self.wanted_regexp
      self.unwanted = self.unwanted_regexp
      load_wanted_wanted_regexp
    	load_unwanted_wanted_regexp
    end
  end

  def clear_to_form
    wanted = nil
    unwanted = nil
  end

private
  def load_wanted_wanted_regexp
    unless wanted_regexp.blank?
      self.wanted_regexp = convert_to_regexp(self.wanted_regexp)
    end
  end

  def load_unwanted_wanted_regexp
    unless unwanted_regexp.blank?
      self.unwanted_regexp = convert_to_regexp(self.unwanted_regexp)
    end
  end

  def convert_to_regexp(data)
    data = data.gsub(/\s/,"\\s")
    data = "\/#{data.gsub(",","|")}\/"
    data
  end
end
