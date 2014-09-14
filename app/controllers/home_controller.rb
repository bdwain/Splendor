class HomeController < ApplicationController

  def index
    render json: {msg: "Splendor"}
  end
end
