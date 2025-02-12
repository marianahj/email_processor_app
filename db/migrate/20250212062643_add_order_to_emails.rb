class AddOrderToEmails < ActiveRecord::Migration[7.1]
  def change
    add_reference :emails, :order, null: false, foreign_key: true
  end
end
