class CatRentalRequestsController < ApplicationController
  def index
    @requests = CatRentalRequest.all
    render :index
  end

  def show
    @request = CatRentalRequest.find(params[:id])
    @cat = Cat.find_by(id: @request.cat_id)
  end

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    #TODO do me next
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_rental_request_url(@request)
    else
      fail "noooooo!!"
    end
  end

  def edit
    @request = CatRentalRequest.find(params[:id])
    @cats = Cat.all
    render :edit
  end

  def update
    #TODO do me after create
    if CatRentalRequest.find(params[:id]).update(request_params)
      redirect_to cat_rental_request_url(params[:id])
    else
      fail "edit fail"
    end
  end

  def approve!
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_rental_request_url(params[:id])
  end

  def deny!
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_rental_request_url(params[:id])
  end

  private
  #TODO strong params
  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end


end
