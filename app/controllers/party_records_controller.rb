class PartyRecordsController < ApplicationController

  before_filter :login_required
  before_filter :load_static_data, :only => [:new, :create, :edit, :update]
  load_and_authorize_resource :except => [:show]

  def index
    @party_records = PartyRecord.paginate(:page => params[:page], :per_page => 25).order(:abbreviation)
  end

  def new
    @party_record = PartyRecord.new
  end

   def show
    @party_record = PartyRecord.find(params[:id])
  end

  def create
    @party_record = PartyRecord.new(params[:party_record])

    if @party_record.save
      redirect_to party_records_path, :notice => 'Party record was successfully created.'
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    @party_record = PartyRecord.find(params[:id])
    respond_to do |format|
      if @party_record.update_attributes(params[:party_record])
        format.html { redirect_to party_records_path, :notice => 'Party record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @party_record.errors, :status => unprocessable_entity }
      end
    end
  end

  def destroy
    @party_record = PartyRecord.find(params[:id])
    @party_record.destroy

    respond_to do |format|
      format.html { redirect_to party_records_url }
      format.json { head :no_content }
    end
  end

  private

  def load_static_data
    @subject_codes = ResearchSubjectCode.all
  end

  def login_required
    if (!PartyRecord.exists? :id => params[:id]) || !PartyRecord.find(params[:id].to_i).published
      authenticate_user!
    end
  end
end