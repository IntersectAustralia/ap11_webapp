class ServiceController  < ApplicationController

  before_filter :login_required
 # load_and_authorize_resource

  def show
    @service = Service.find(params[:id])
  end

  private
  def login_required
    if !Service.exists?(params[:id]) || !Service.find(params[:id]).published
      authenticate_user!
    end
  end

end