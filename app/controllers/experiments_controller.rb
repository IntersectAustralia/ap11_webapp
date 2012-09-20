class ExperimentsController < ApplicationController

  before_filter :load_static_data, :only => [:new, :edit, :create, :update]
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @experiments = Experiment.all
  end

  def show
    @experiment = Experiment.find(params[:id])
    @input_collections = InputCollection.find_all_by_experiment_id(@experiment.id)
    @output_collections = OutputCollection.find_all_by_experiment_id(@experiment.id)
  end

  def new
    @experiment = Experiment.new
    @date = Date.current
  end

  def edit
    @experiment = Experiment.find(params[:id])
    @input_collections = InputCollection.find_all_by_experiment_id(@experiment.id)
    @output_collections = OutputCollection.find_all_by_experiment_id(@experiment.id)
  end

  def create
    @experiment = Experiment.new(params[:experiment])

    if @experiment.save
      redirect_to experiments_path, notice: 'Experiment was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @experiment = Experiment.find(params[:id])
    @input_collections = InputCollection.find_all_by_experiment_id(@experiment.id)
    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        format.html { redirect_to experiments_path, notice: 'Experiment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @experiment = Experiment.find(params[:id])
    @experiment.destroy

    respond_to do |format|
      format.html { redirect_to experiments_url }
      format.json { head :no_content }
    end
  end

  private

  def load_static_data
    @users = User.all(:order => :id)
  end
end
