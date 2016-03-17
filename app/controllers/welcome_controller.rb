class WelcomeController < ApplicationController

  def index
    @latest = News.order("published desc").limit(7)
    respond_to do |format|
      format.html
      format.json { render :json => @latest }
    end
  end

end
