class EmailsController < ApplicationController
  def index
    @emails = Email.all.order(created_at: :desc)
  end

  def show
    @email = Email.find(params[:id])
  end

  def fetch
    EmailFetcherService.fetch_emails
    redirect_to emails_path, notice: "Emails fetched successfully!"
  end

  def analyze
    email = Email.find(params[:email_id])
    OpenAIProcessorService.analyze_email(email) # This should call your AI processing logic
    redirect_to processed_emails_path, notice: "AI Processing completed!"
  end
end
