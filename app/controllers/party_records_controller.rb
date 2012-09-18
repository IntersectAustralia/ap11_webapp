class PartyRecordsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @party_record = PartyRecord.new
  end


  def create
    @party_record = PartyRecord.new(params[:party_record])

    if @party_record.save
      redirect_to "/", notice: 'Party record was successfully created.'
    else
      render action: "new"
    end
  end

  private


end