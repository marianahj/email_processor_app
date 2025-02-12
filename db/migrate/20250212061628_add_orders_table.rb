class AddOrdersTable < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :product_name
      t.string :state

      t.timestamps
    end
  end
end
