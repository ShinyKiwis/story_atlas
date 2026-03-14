class User < ApplicationRecord
  has_secure_password validations: false

  validates :username, presence: true

  has_many :sessions, dependent: :destroy
end
