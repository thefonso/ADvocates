class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new
    
  end

  def create
    business = Business.new(business_params)
    if business.save
      @business = Business.where(name: params[:business][:name]).first
      session[:business_id] = @business.id.to_s
      redirect_to businesses_path
    else
      render 'new'
    end
  end

  def edit
    @business = Business.find(params[:id])
  end

  def update
    @business = Business.find(params[:id])
    if @business.update_attributes(business_params)
      redirect_to business_path
    else
      render 'edit'
    end
  end

  def destroy
    Business.find(params[:id]).destroy
    reset_session
    redirect_to businesses_path
  end

  private

  def business_params
    params.require(:business).permit(:name, :email, :password, :password_confirmation)
  end

end
