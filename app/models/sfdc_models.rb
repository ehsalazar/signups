# Container into which you will materialize the Salesforce objects.
module SFDC_Models
  include Databasedotcom::Rails::Controller

  def populate_salesforce(name)
    client = Databasedotcom::Client.new
    client.authenticate :username => 'ehsalazar+sfapi@me.com', :password => 'envoy2015o3Zom5Uo8jaJXTjnRGoC1lzQw'
    client.sobject_module = 'SFDC_Models'
    client.materialize('Account')
    dummy = Account.new
    dummy.Name = name
    dummy.OwnerId = '005j000000BnwumAAB'
    dummy.save
  end
end
