class ApiWorker
  include SFDC_Models
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    Clearbit.key = ENV['CLEARBIT_KEY']
    domain = "#{user.company_name.split.join}.com"
    company_data = Clearbit::Streaming::Company[domain: domain]
    @company = Company.create(name: user.company_name)
    @company.users << user
    # self.populate_salesforce(@company)
  end
end