class OutputCollectionsController < ApplicationController
  # GET /output_collections
  # GET /output_collections.json
  def index
    @output_collections = OutputCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @output_collections }
    end
  end

  # GET /output_collections/1
  # GET /output_collections/1.json
  def show
    @output_collection = OutputCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @output_collection }
    end
  end

  # GET /output_collections/new
  # GET /output_collections/new.json
  def new
    @output_collection = OutputCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @output_collection }
    end
  end

  # GET /output_collections/1/edit
  def edit
    @output_collection = OutputCollection.find(params[:id])
  end

  # POST /output_collections
  # POST /output_collections.json
  def create
    @output_collection = OutputCollection.new(params[:output_collection])

    respond_to do |format|
      if @output_collection.save
        format.html { redirect_to @output_collection, notice: 'Output collection was successfully created.' }
        format.json { render json: @output_collection, status: :created, location: @output_collection }
      else
        format.html { render action: "new" }
        format.json { render json: @output_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /output_collections/1
  # PUT /output_collections/1.json
  def update
    @output_collection = OutputCollection.find(params[:id])

    respond_to do |format|
      if @output_collection.update_attributes(params[:output_collection])
        format.html { redirect_to @output_collection, notice: 'Output collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @output_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /output_collections/1
  # DELETE /output_collections/1.json
  def destroy
    @output_collection = OutputCollection.find(params[:id])
    @output_collection.destroy

    respond_to do |format|
      format.html { redirect_to output_collections_url }
      format.json { head :no_content }
    end
  end
end
