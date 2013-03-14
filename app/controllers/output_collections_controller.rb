class OutputCollectionsController < ApplicationController

  before_filter :load_static_data, :only => [:new, :create, :edit, :update]
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @output_collections = OutputCollection.all
  end

  def show
    @output_collection = OutputCollection.find(params[:id])
    @experiment = Experiment.find(@output_collection.experiment_id)
  end

  def new
    @output_collection = OutputCollection.new
    @experiment = Experiment.find(params[:experiment_id])
  end

  def edit
    @output_collection = OutputCollection.find(params[:id])
    @experiment = Experiment.find(params[:experiment_id])
  end

  def create
    experiment_id = params[:experiment_id]

    @output_collection = OutputCollection.new(params[:output_collection])
    @output_collection.experiment_id = experiment_id
    @experiment = Experiment.find(experiment_id)
    unless @experiment.has_output_collection?
      if @output_collection.save
        redirect_to edit_experiment_path(experiment_id), :notice => 'Output collection was successfully created.'
      else
        render :action => "new"
      end
    end
  end

  def update
    experiment_id = params[:experiment_id]

    @output_collection = OutputCollection.find(params[:id])
    @output_collection.experiment_id = experiment_id
    @experiment = Experiment.find(experiment_id)

    if @output_collection.update_attributes(params[:output_collection])
      redirect_to edit_experiment_path(experiment_id), :notice => 'Output collection was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @output_collection = OutputCollection.find(params[:id])
    @output_collection.destroy
    redirect_to edit_experiment_path(params[:experiment_id])
  end

  private

  def load_static_data
    @subject_codes = ResearchSubjectCode.all
  end
end
