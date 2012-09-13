class OutputCollectionsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @output_collections = OutputCollection.all
  end

  def show
    @output_collection = OutputCollection.find(params[:id])
  end

  def new
    @output_collection = OutputCollection.new
  end

  def edit
    @output_collection = OutputCollection.find(params[:id])
  end

  def create
    @output_collection = OutputCollection.new(params[:output_collection])

    if @output_collection.save
      redirect_to @output_collection, notice: 'Output collection was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @output_collection = OutputCollection.find(params[:id])

    if @output_collection.update_attributes(params[:output_collection])
      redirect_to @output_collection, notice: 'Output collection was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @output_collection = OutputCollection.find(params[:id])
    @output_collection.destroy
    redirect_to output_collections_url
  end
end
