class UsersController < ApplicationController
  include SessionsHelper
  include SFDC_Models

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      self.company_builder
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
    domain = "#{@user.company_name.split.join}.com"
    company = Clearbit::Streaming::Company[domain: domain]
  end

  def company_builder
    @company = Company.create(name: @user.company_name, metadata: self.clearbit)
    @company.users << @user
    self.populate_salesforce(@company)
  end


  private

  def user_params
    params.require(:user).permit(:name, :company_name, :phone_number, :email, :password)
  end
end