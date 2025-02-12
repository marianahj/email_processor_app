class Email < ApplicationRecord
  has_one :processed_email, dependent: :destroy # When an email is deleted, its processed_email is also deleted
end
