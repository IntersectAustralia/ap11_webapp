class OutputCollection < ActiveRecord::Base
  attr_accessible :experiment_id, :name, :license, :access_rights, :location, :for_code1, :for_code2, :for_code3,
                  :description, :website_name, :url

  belongs_to :experiment

  validates_length_of :name, :maximum => 512
  validates_length_of :license, :maximum => 2000
  validates_length_of :access_rights, :maximum => 2000
  validates_length_of :location, :maximum => 2000
  validates_length_of :website_name, :maximum => 512
  validates_length_of :url, :maximum => 2000

  validates_presence_of :for_code1
  validates_presence_of :url, :if => :website_name_exists?
  validates_presence_of :website_name, :if => :url_exists?

  def website_name_exists?
    !website_name.blank?
  end

  def url_exists?
    !url.blank?
  end
end
