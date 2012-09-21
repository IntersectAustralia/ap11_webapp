class PartyRecordsController < ApplicationController

  before_filter :load_static_data, :only => [:new, :create, :edit, :update]
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    #AP11-93
  end

  def new
    @party_record = PartyRecord.new
  end

  def create
    @party_record = PartyRecord.new(params[:party_record])

    if @party_record.save
      redirect_to party_records_path, notice: 'Party record was successfully created.'
    else
      render action: "new"
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def load_static_data
    @subject_codes = ResearchSubjectCode.all
  end
end