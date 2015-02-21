require 'rails_helper'

describe CompaniesController do
  context '#create' do
    it 'should create a new user' do
      company = FactoryGirl.create(:company)
      expect( Company.count ).to eq(1)
    end
  end
end