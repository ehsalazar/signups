class Builder
  include Sidekiq::Worker

  def perform(user)
    user.company_builder
  end
end