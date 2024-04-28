class User < ApplicationRecord
  has_one :user_address

  accepts_nested_attributes_for :user_address
end
