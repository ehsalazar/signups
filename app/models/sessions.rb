class Session < ActiveRecord::Base
    attr_accessor :password, :password_digest
  validates_presence_of :password, :on => :create

has_secure_password validations: false
validates :password, presence: true
end
