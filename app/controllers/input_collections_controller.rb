class InputCollectionsController < ApplicationController

  before_filter :load_static_data, :only => [:new, :create, :edit, :update]
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @input_collections = InputCollection.all
  end

  def show
    @input_collection = InputCollection.find(params[:id])
    @experiment = Experiment.find(@input_collection.experiment_id)
  end

  def new
    @input_collection = InputCollection.new
    @experiment = Experiment.find(params[:experiment_id])
  end

  def edit
    @input_collection = InputCollection.find(params[:id])
    @experiment = Experiment.find(params[:experiment_id])
  end

  def create
    experiment_id = params[:experiment_id]

    @input_collection = InputCollection.new(params[:input_collection])
    @input_collection.experiment_id = experiment_id
    @experiment = Experiment.find(experiment_id)

    if @input_collection.save
      redirect_to edit_experiment_path(experiment_id), notice: 'Input collection was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    experiment_id = params[:experiment_id]

    @input_collection = InputCollection.find(params[:id])
    @input_collection.experiment_id = experiment_id
    @experiment = Experiment.find(experiment_id)

    if @input_collection.update_attributes(params[:input_collection])
      redirect_to edit_experiment_path(experiment_id), notice: 'Input collection was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @input_collection = InputCollection.find(params[:id])
    @input_collection.destroy
    redirect_to edit_experiment_path(params[:experiment_id])
  end

  private

  def load_static_data
    @subject_codes = ResearchSubjectCode.all
    @party_records = PartyRecord.all
  end
end
