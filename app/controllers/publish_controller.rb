class PublishController < ApplicationController

  before_filter :authenticate_user!

  def view
    @experiment = Experiment.find(params[:id])
    if @experiment.published?
      redirect_to(@experiment, :notice => "Experiment has been published to ANDS")
    else
      @input_collections = InputCollection.find_all_by_experiment_id(@experiment.id)
      @output_collections = OutputCollection.find_all_by_experiment_id(@experiment.id)
    end
  end

  def confirm
    experiment = Experiment.find(params[:id])
    if experiment.published?
      redirect_to(experiment, :notice => "Experiment has already been published to ANDS")
    else
      experiment.publish
      redirect_to(experiment, :notice => "Experiment has been published to ANDS")
    end
  end

  def cancel
    experiment = Experiment.find(params[:id])
    redirect_to(experiment, :alert => "Experiment has not been published")
  end

  def unpublish
    experiment = Experiment.find(params[:id])
    experiment.unpublish
    redirect_to(experiment, :notice => "Experiment has been unpublished from ANDS")
  end
end