class UsersController < ApplicationController
  include SessionsHelper

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      # self.company_builder
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

  # def clearbit
    # Clearbit.key = ENV['CLEARBIT_KEY']
    # domain = "#{@user.company_name.split.join}.com"
    # company = Clearbit::Streaming::Company[domain: domain]
  # end

  # def company_builder(user_id)
    # user = User.find(user_id)
    # @company = Company.create(name: user.company_name, metadata: self.clearbit)
    # @company.users << user
    # self.populate_salesforce(@company)
    # @company = Company.create(name: @user.company_name, metadata: self.clearbit)
    # @company.users << @user
    # self.populate_salesforce(@company)
  # end

  private

  def user_params
    params.require(:user).permit(:name, :company_name, :phone_number, :email, :password)
  end
end