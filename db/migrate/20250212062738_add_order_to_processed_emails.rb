class AddOrderToProcessedEmails < ActiveRecord::Migration[7.1]
  def change
    add_reference :processed_emails, :order, null: false, foreign_key: true
  end
end
