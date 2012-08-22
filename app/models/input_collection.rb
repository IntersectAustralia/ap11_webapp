class InputCollection < ActiveRecord::Base
  attr_accessible :collection_id, :experiment_id

  belongs_to :experiment
  belongs_to :collection
end
