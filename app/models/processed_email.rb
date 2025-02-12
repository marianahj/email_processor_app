class ProcessedEmail < ApplicationRecord
  belongs_to :email, required: true, inverse_of: :processed_email
  validates_uniqueness_of :email_id

end
