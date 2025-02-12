class Order < ApplicationRecord
  has_many :emails, dependent: :destroy
  has_many :processed_emails, dependent: :destroy
end