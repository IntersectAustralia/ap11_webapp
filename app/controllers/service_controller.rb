class ServiceController  < ApplicationController
  #before_filter :only => [:new, :create, :edit, :update]
  before_filter :authenticate_user!
  load_and_authorize_resource

  def show
  end


end