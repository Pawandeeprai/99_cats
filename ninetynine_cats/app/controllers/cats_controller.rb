# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      fail "didn't save :("
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    if Cat.find(params[:id]).update(cat_params)
      redirect_to cat_url(params[:id])
    else
      fail "didn't update :("
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :description, :color)
  end

end
