class HomeController < ApplicationController
  def index
    redirect_to analyses_path
  end
end
