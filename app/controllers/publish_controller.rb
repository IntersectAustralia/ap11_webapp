class PublishController < ApplicationController

  before_filter :authenticate_user!

  def view
    @experiment = Experiment.find(params[:id])
    @input_collections = InputCollection.find_all_by_experiment_id(@experiment.id)
    @output_collections = OutputCollection.find_all_by_experiment_id(@experiment.id)
  end

  def confirm
    experiment = Experiment.find(params[:id])
    experiment.publish
    redirect_to(experiment, :notice => "Experiment has been published to ANDS")
  end

  def cancel
    experiment = Experiment.find(params[:id])
    redirect_to(experiment, :alert => "Experiment has not been published")
  end

end