class Experiment < ActiveRecord::Base
  attr_accessible :date, :title, :user_id

  belongs_to :user

  has_many :input_collection, :through => :collections
  has_one :output_collection, :through => :collections

  validates :date,  :presence => true
  validates :title, :presence => true
end
