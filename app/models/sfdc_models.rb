# Container into which you will materialize the Salesforce objects.
module SFDC_Models
  include Databasedotcom::Rails::Controller

  def populate_salesforce(company)
    client = Databasedotcom::Client.new
    client.authenticate :username => ENV['SALESFORCE_USERNAME'], :password => ENV['SALESFORCE_PASSWORD']
    client.sobject_module = 'SFDC_Models'
    client.materialize('Account')

    account_details = {
      OwnerId: '005j000000BnwumAAB',
      Phone: company.users.first.phone_number,
      Name: company.users.first.company_name, #Will be used only if no legal name is returned from Clearbit
      Type: 'prospect'
    }

    if company.metadata != nil && !( company.metadata.empty? )
      if company.metadata.has_key?('legal_name') && company.metadata['legal_name'] != nil && company.metadata['legal_name'] != ''
        account_details['Name'] = company.metadata['legal_name']
      end
      account_details.update(
        NumberOfEmployees: company.metadata['employees'],
        Website: company.metadata['url'],
        Description: company.metadata['description']
      )
      if company.metadata.has_key?('geo') && company.metadata['geo'] != nil
        account_details.update(
          BillingCity: company.metadata['geo']['city'],
          BillingState: company.metadata['geo']['state'],
          BillingCountry: company.metadata['geo']['country']
        )
      end
    end

#    account = Account.new(account_details)
#    account_id = account.save

    account = Account.find_by_Name("#{account_details['Name']}")
    # Interpolate because Salesforce requires literal search string
    # (databasedotcom incorrectly tries a bind variable; see
    #  stackoverflow.com/questions/26078967)
    if account == nil
      account = Account.new(account_details)
      account_id = account.save
    else
      account.update_attributes(account_details)
    # Will not work on a new record due to automatic save included in update_attribute.
      account_id = account['Id']
    end

    client.materialize('Contact')

    contact_details = {
      AccountId: account_id,
      OwnerId: '005j000000BnwumAAB',
      LastName: company.users.first.name,
      Phone: company.users.first.phone_number,
      Email: company.users.first.email
    }

    if company.metadata != nil && company.metadata.has_key?('geo') && company.metadata['geo'] != nil
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