class UsersController < ApplicationController
  include SessionsHelper

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def company_info
    @user = User.find(params[:id])
    domain = "#{@user.company_name}.com"
    api = Clearbit::Client.new
    @info = api.get_company_info(domain)
    render partial: "info"
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :company_name, :phone_number, :email, :password)
  end
end