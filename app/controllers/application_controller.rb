class ApplicationController < ActionController::Base
  def index
    redirect_to recipes_url
  end    
end
