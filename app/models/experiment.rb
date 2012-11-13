class Experiment < ActiveRecord::Base
  attr_accessible :date, :title, :user_id, :published

  belongs_to :user

  has_many :input_collection, :foreign_key => 'experiment_id', :dependent => :destroy
  has_one :output_collection, :foreign_key => 'experiment_id', :dependent => :destroy

  validates :date,  :presence => true
  validates :title, :presence => true

  def has_output_collection?
    exp = OutputCollection.find_all_by_experiment_id(self)
    exp.length >= 1
  end

  def publish
    self.published = true
    input_collection = InputCollection.find_all_by_experiment_id(id)
    output_collection = OutputCollection.find_all_by_experiment_id(id)
    input_collection.each do |input|
      input.published = true
      input.save!
    end
    output_collection.each do |output|
      output.published = true
      output.save!
    end
    self.save!
  end
end
