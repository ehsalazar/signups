class UsersController < ApplicationController
  include SessionsHelper

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ApiWorker.perform_async(@user.id)
      redirect_to user_path(@user)
    else
      flash[:error] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:name, :company_name, :phone_number, :email, :password)
  end
end