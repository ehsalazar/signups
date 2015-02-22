# Container into which you will materialize the Salesforce objects.
module SFDC_Models
  include Databasedotcom::Rails::Controller

  def populate_salesforce(company)
    client = Databasedotcom::Client.new
    client.authenticate :username => ENV['SALESFORCE_USERNAME'], :password => ENV['SALESFORCE_PASSWORD']
    client.sobject_module = 'SFDC_Models'
    client.materialize('Account')
    dummy = Account.new(Name: company.metadata['legal_name'], OwnerId: '005j000000BnwumAAB', Phone: company.users.first.phone_number, BillingCity: company.metadata['geo']['city'], BillingState: company.metadata['geo']['state'], BillingCountry: company.metadata['geo']['country'], NumberOfEmployees: company.metadata['employees'], Description: company.metadata['description'], Website: company.metadata['url'], Type: 'prospect')
    account_id = dummy.save
  end
end

# yahoo.Name = company.metadata['legal_name']
# yahoo.OwnerId = '005j000000BnwumAAB'
# yahoo.Phone = company.users.first.phone_number
# yahoo.BillingCity = company.metadata['geo']['city']
# yahoo.BillingState = company.metadata['geo']['state']
# yahoo.BillingCountry = company.metadata['geo']['country']
# yahoo.NumberOfEmployees = company.metadata['employees']
# yahoo.Description = company.metadata['description']
# yahoo.Website = company.metadata['url']
# yahoo.Type = 'prospect'