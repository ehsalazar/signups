# Container into which you will materialize the Salesforce objects.
module SFDC_Models
  include Databasedotcom::Rails::Controller

  def populate_salesforce(name)
    client = Databasedotcom::Client.new
    client.authenticate :username => ENV['SALESFORCE_USERNAME'], :password => ENV['SALESFORCE_PASSWORD']
    client.sobject_module = 'SFDC_Models'
    client.materialize('Account')
    dummy = Account.new
    dummy.Name = name
    dummy.OwnerId = '005j000000BnwumAAB'
    dummy.save
  end
end


#Salesforce fields: account name, type: prospect, annual revenue, phone, fax, website, ticker symbol, employees, ownership, billing street, billing city, billing state, billing postal code, billing country, description