class User < ActiveRecord::Base
  belongs_to :user
  has_secure_password
  validates :email, presence:true, uniqueness: true
  validates :company_name, :name, presence: true
end