class ToppagesController < ApplicationController
  def index
    if logged_in?
      @place = current_user.places.build #form_with用でnewにおく？
      @places = current_user.places.order(id: :desc).page(params[:page])
    end
  end
end
