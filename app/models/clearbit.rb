module Clearbit

  class Client
    Clearbit.key = ENV['CLEARBIT_KEY']

    def get_company_info(domain)
      response = Clearbit::Streaming::Company[domain: domain ]
      parse_company_info(response)
    end

    def parse_company_info
      info = []

    end

  end

end