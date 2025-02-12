class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.string :subject
      t.string :sender
      t.text :body
      t.text :processed_summary

      t.timestamps
    end
  end
end
