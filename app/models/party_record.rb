class PartyRecord < ActiveRecord::Base
  attr_accessible :abbreviation, :access_rights, :address, :description, :for_code1, :for_code2, :for_code3,
                  :full_name, :license, :url

  before_validation :strip_whitespace

  validates_presence_of :abbreviation
  validates_presence_of :full_name
  validates_presence_of :description
  validates_presence_of :address
  validates_presence_of :access_rights
  validates_presence_of :license

  validates_length_of :abbreviation, :maximum => 25
  validates_length_of :full_name, :maximum => 255
  validates_length_of :url, :maximum => 2000

  validates_uniqueness_of :abbreviation, :case_sensitive => false

  protected

  def strip_whitespace
    self.abbreviation.strip! unless abbreviation.blank?
  end
end
