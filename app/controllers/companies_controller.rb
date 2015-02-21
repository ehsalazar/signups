class CompaniesController < ApplicationController

  def create
    @company = Company.new(comp_params)
  end

  private

  def comp_params
    params.require(:company).permit(:name, :metadata)
  end
end