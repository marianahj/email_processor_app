class ChangeOrderIdNullInEmailsAndProcessedEmails < ActiveRecord::Migration[7.1]
  def change
    change_column_null :emails, :order_id, true
    change_column_null :processed_emails, :order_id, true
  end
end
