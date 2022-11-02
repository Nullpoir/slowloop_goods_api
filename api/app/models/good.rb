class Good < ApplicationRecord
  has_many :good_users
  has_many :users, through: :good_users
end
