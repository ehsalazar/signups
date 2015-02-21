require 'rails_helper'

describe UsersController do

  context '#create' do

    it 'should create a new user' do
      user = FactoryGirl.create(:user)
      expect( User.count ).to eq(1)
    end

    let(:company) {FactoryGirl.create(:company)}
    it 'should create a user associated to a company' do
      user = company.users.create(name: 'John')
      expect(user.company_id).to eq(company.id)
    end

  end

end
