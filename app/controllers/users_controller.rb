class UsersController < ApplicationController
  include SessionsHelper

  def create
    @user = User.new(user_params)
    self.clearbit
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

  def clearbit
    Clearbit.key = ENV['CLEARBIT_KEY']
    domain = "#{@user.company_name}.com"
    company = Clearbit::Streaming::Company[domain: domain]
    puts company
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :company_name, :phone_number, :email, :password)
  end
end