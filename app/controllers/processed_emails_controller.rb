class ProcessedEmailsController < ApplicationController
  def index
    @processed_emails = ProcessedEmail.all.order(created_at: :desc)
  end
end