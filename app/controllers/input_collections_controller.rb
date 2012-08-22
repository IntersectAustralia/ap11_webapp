class InputCollectionsController < ApplicationController
  # GET /input_collections
  # GET /input_collections.json
  def index
    @input_collections = InputCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @input_collections }
    end
  end

  # GET /input_collections/1
  # GET /input_collections/1.json
  def show
    @input_collection = InputCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @input_collection }
    end
  end

  # GET /input_collections/new
  # GET /input_collections/new.json
  def new
    @input_collection = InputCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @input_collection }
    end
  end

  # GET /input_collections/1/edit
  def edit
    @input_collection = InputCollection.find(params[:id])
  end

  # POST /input_collections
  # POST /input_collections.json
  def create
    @input_collection = InputCollection.new(params[:input_collection])

    respond_to do |format|
      if @input_collection.save
        format.html { redirect_to @input_collection, notice: 'Input collection was successfully created.' }
        format.json { render json: @input_collection, status: :created, location: @input_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @input_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /input_collections/1
  # PUT /input_collections/1.json
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

  # DELETE /input_collections/1
  # DELETE /input_collections/1.json
  def destroy
    @input_collection = InputCollection.find(params[:id])
    @input_collection.destroy

    respond_to do |format|
      format.html { redirect_to input_collections_url }
      format.json { head :no_content }
    end
  end
end
