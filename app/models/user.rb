class User < ActiveRecord::Base
  belongs_to :user
  has_secure_password
end