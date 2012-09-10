class InputCollectionsController < ApplicationController

  before_filter :load_static_data, :only => [:new, :create, :edit, :update]

  def index
    @input_collections = InputCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @input_collections }
    end
  end

  def show
    @input_collection = InputCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @input_collection }
    end
  end

  def new
    @input_collection = InputCollection.new
    @experiment = Experiment.find(params[:experiment_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @input_collection }
    end
  end

  def edit
    @input_collection = InputCollection.find(params[:id])
    @experiment = Experiment.find(params[:experiment_id])
  end

  def create
    @input_collection = InputCollection.new(params[:input_collection])
    experiment_id = params[:experiment_id]
    @input_collection.experiment_id = experiment_id

    respond_to do |format|
      if @input_collection.save
        format.html { redirect_to edit_experiment_path(experiment_id), notice: 'Input collection was successfully created.' }
        format.json { render json: @input_collection, status: :created, location: @input_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @input_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @input_collection = InputCollection.find(params[:id])

    respond_to do |format|
      if @input_collection.update_attributes(params[:input_collection])
        format.html { redirect_to @input_collection, notice: 'Input collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @input_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @input_collection = InputCollection.find(params[:id])
    @input_collection.destroy

    respond_to do |format|
      format.html { redirect_to edit_experiment_path(params[:experiment_id]) }
      format.json { head :no_content }
    end
  end

  def load_static_data
    @subject_codes = ResearchSubjectCode.all
  end
end
