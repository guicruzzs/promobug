class Interest < ActiveRecord::Base
  belongs_to :agenda
  belongs_to :user
  has_many :schedules
  
  validate :fill_out_wishes
  before_save :load_regexp

  ACTIVE_STATUS = true
  INATCIVE_STATUS = false

  named_scope :active, :conditions=>{:status=> Interest::ACTIVE_STATUS}

  def inactivate
    self.status = Interest::INATCIVE_STATUS
    self.save
  end

  def self.test
    offer = Offer.find 19
    Interest.verify(offer)
    puts "FIM TESTE"
  end

  def self.verify(offer)
    offer.twitter_message.gsub!(offer.link, "")
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
      errors.add(:filter, "É obrigatório o preenchimento ao menos do(s) Desejado(s)")
    end
  end

  def load_regexp
    puts "LOAD REGEXP"
  	if self.status == Interest::ACTIVE_STATUS
      self.wanted_regexp = "" if self.wanted_regexp.nil?
      self.unwanted_regexp = "" if self.unwanted_regexp.nil?
      self.wanted = self.wanted_regexp.gsub(",", ",\s")
      self.unwanted = self.unwanted_regexp.gsub(",", ",\s")
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
