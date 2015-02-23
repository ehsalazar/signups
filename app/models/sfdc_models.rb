# Container into which you will materialize the Salesforce objects.
module SFDC_Models
  include Databasedotcom::Rails::Controller

  def populate_salesforce(company)
    client = Databasedotcom::Client.new
    client.authenticate :username => ENV['SALESFORCE_USERNAME'], :password => ENV['SALESFORCE_PASSWORD']
    client.sobject_module = 'SFDC_Models'
    client.materialize('Account')

    account_details = {
      Name: company.metadata['legal_name'],
      OwnerId: '005j000000BnwumAAB',
      Phone: company.users.first.phone_number,
      NumberOfEmployees: company.metadata['employees'],
      Description: company.metadata['description'],
      Website: company.metadata['url'],
      Type: 'prospect'
    }

    if company.metadata.has_key? 'geo' && company.metadata['geo'] != nil
      account_details.update(
        BillingCity: company.metadata['geo']['city'],
        BillingState: company.metadata['geo']['state'],
        BillingCountry: company.metadata['geo']['country']
      )
    end

    account = Account.new(account_details)
    account_id = account.save
    client.materialize('Contact')

    contact_details = {
      AccountId: account_id,
      OwnerId: '005j000000BnwumAAB',
      LastName: company.users.first.name,
      Phone: company.users.first.phone_number,
      Email: company.users.first.email,
    }

    if company.metadata.has_key? 'geo' && company.metadata['geo'] != nil
      contact_details.update(
        MailingCity: company.metadata['geo']['city'],
        MailingState: company.metadata['geo']['state'],
        MailingCountry: company.metadata['geo']['country']
      )
    end

    Contact.create(contact_details)
    client.materialize('Opportunity')

    opportunity_details = {
      AccountId: account_id,
      OwnerId: '005j000000BnwumAAB',
      Name: 'Trial', Type: 'New Customer',
      CloseDate: Date.today.advance(months: 3),
      StageName: 'Prospecting'
    }

    Opportunity.create(opportunity_details)
  end
end