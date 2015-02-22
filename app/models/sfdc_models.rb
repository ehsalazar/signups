# Container into which you will materialize the Salesforce objects.
module SFDC_Models
  include Databasedotcom::Rails::Controller

  def populate_salesforce(company)
    client = Databasedotcom::Client.new
    client.authenticate :username => ENV['SALESFORCE_USERNAME'], :password => ENV['SALESFORCE_PASSWORD']
    client.sobject_module = 'SFDC_Models'
    client.materialize('Account')
    account = Account.new(Name: company.metadata['legal_name'], OwnerId: '005j000000BnwumAAB', Phone: company.users.first.phone_number, BillingCity: company.metadata['geo']['city'], BillingState: company.metadata['geo']['state'], BillingCountry: company.metadata['geo']['country'], NumberOfEmployees: company.metadata['employees'], Description: company.metadata['description'], Website: company.metadata['url'], Type: 'prospect')
    account_id = account.save
    client.materialize('Contact')
    Contact.create(AccountId: account_id, OwnerId: '005j000000BnwumAAB', LastName: company.users.first.name, Phone: company.users.first.phone_number, Email: company.users.first.email, MailingCity: company.metadata['geo']['city'], MailingState: company.metadata['geo']['state'], MailingCountry: company.metadata['geo']['country'])
    client.materialize('Opportunity')
    Opportunity.create(AccountId: account_id, OwnerId: '005j000000BnwumAAB', Name: 'Trial', Type: 'New Customer', CloseDate: Date.today.advance(months: 3), StageName: 'Prospecting')
  end
end

# Needed to populate Account
# account.Name = company.metadata['legal_name']
# account.OwnerId = '005j000000BnwumAAB'
# account.Phone = company.users.first.phone_number
# account.BillingCity = company.metadata['geo']['city']
# account.BillingState = company.metadata['geo']['state']
# account.BillingCountry = company.metadata['geo']['country']
# account.NumberOfEmployees = company.metadata['employees']
# account.Description = company.metadata['description']
# account.Website = company.metadata['url']
# account.Type = 'prospect'

# Needed to populate Contact
# contact.AccountId = account_id
# contact.OwnerId = '005j000000BnwumAAB'
# contact.LastName = company.users.first.name
# contact.Phone = company.users.first.phone_number
# contact.Email = company.users.first.email
# contact.MailingCity = company.metadata['geo']['city']
# contact.MailingState = company.metadata['geo']['state']
# contact.MailingCountry = company.metadata['geo']['country']

# Needed to populate Opportunity
# opportunity.AccountId = account_id
# opportunity.OwnerId = '005j000000BnwumAAB'
# opportunity.Name = 'Trial'
# opportunity.Type = 'New Customer'
# opportunity.CloseDate = Date.today.advance(months: 3)
# opportunity.StageName = 'Prospecting'