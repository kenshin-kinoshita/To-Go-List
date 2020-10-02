class PlacesController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @place = current_user.places.build
  end

  def create
    @place = current_user.places.build(place_params)
    if @place.save
      flash[:success] = '行きたい所リストに追加しました。'
      redirect_to root_url
    else
      flash[:danger] = 'リストの追加に失敗しました。'
      render :new
    end
  end

  def destroy
    @place = current_user.places.find_by(id: params[:id])
    if @place.destroy
      flash[:success] = 'リストから削除しました。'
      redirect_to root_url
    else
      @places = current_user.places.order(id: :desc).page(params[:page])
      render :new #ここなに？
    end
  end
  
  private
  
  def place_params
    params.require(:place).permit(:name, :prefecture, :priority)
  end
end
