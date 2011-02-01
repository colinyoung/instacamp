class WelcomeController < ApplicationController
  def index
    @search = Search.new
  end

  def about
  end

end
