require 'net/imap'
require 'mail'

class EmailFetcherService
  IMAP_SERVER = 'imap.gmail.com'  # Change for Outlook, Yahoo, etc.
  IMAP_PORT = 993
  EMAIL_ADDRESS = ENV['EMAIL_USERNAME']
  PASSWORD = ENV['EMAIL_PASSWORD']

  def self.fetch_emails
    imap = Net::IMAP.new(IMAP_SERVER, IMAP_PORT, true)  # Enable SSL
    imap.login(EMAIL_ADDRESS, PASSWORD)
    imap.select('INBOX')

    # Search for unread emails
    email_ids = imap.search(["UNSEEN"])

    email_ids.each do |email_id|
      msg = imap.fetch(email_id, "RFC822")[0].attr["RFC822"] # RFC822 is the format of the email
      mail = Mail.read_from_string(msg) # Parse the email

      # Extract email details
      email_subject = mail.subject
      email_body = mail.text_part ? mail.text_part.body.decoded : mail.body.decoded
      sender_email = mail.from.first

      puts "📩 New Email from: #{sender_email}"
      puts "📌 Subject: #{email_subject}"
      puts "📝 Body: #{email_body.force_encoding('UTF-8').encode('UTF-8', invalid: :replace, undef: :replace, replace: '?').truncate(300)}"

      # Process email with OpenAI
      processed_data = OpenAIProcessorService.analyze_email(email_body)
      puts "🔍 Extracted Data: #{processed_data}"

      # Mark email as read
      imap.store(email_id, "+FLAGS", [:Seen])
    end

    imap.logout
    imap.disconnect
  end
end