class WelcomeController < ApplicationController

  def index
    @latest = News.latest
    respond_to do |format|
      format.html
      format.json { render :json => @latest }
    end
  end

end
