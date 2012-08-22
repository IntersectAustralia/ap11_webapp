class Collection < ActiveRecord::Base
  attr_accessible :citation_info, :description, :for_codes, :name, :experiment_id

  belongs_to :experiment

  #validation_group :step1, :fields => [:name, :description]
  #TEST
  def set_experiment(id)
    return if id.nil? || id.empty?
    self.experiment_id = id
  end

end
