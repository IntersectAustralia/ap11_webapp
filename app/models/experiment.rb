class Experiment < ActiveRecord::Base
  attr_accessible :date, :title, :user_id

  belongs_to :user

  has_many :input_collection, :foreign_key => 'experiment_id'
  has_one :output_collection, :foreign_key => 'experiment_id'

  validates :date,  :presence => true
  validates :title, :presence => true

  def has_output_collection?
    exp = OutputCollection.find_all_by_experiment_id(self)
    exp.length >= 1
  end

end
