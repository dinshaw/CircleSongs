class ContactForm < MailForm::Base
  DEFAULT_FROM_NAME = 'Contact Form'.freeze
  DEFAULT_FROM_EMAIL = Rails.application.credentials.from_email
  DEFAULT_SUBJECT = "Hi from #{Rails.application.credentials.base_domain}!".freeze

  attribute :name
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, allow_blank: true
  attribute :subject
  attribute :message, validate: true
  attribute :nickname, captcha: true

  def headers
    {
      subject: subject_text,
      to: Rails.application.credentials.contact_form_email,
      from: "#{from_name} <#{from_email}>"
    }
  end

  private

  def from_name
    name.blank? ? DEFAULT_FROM_NAME : name
  end

  def from_email
    email.blank? ? DEFAULT_FROM_EMAIL : email
  end

  def subject_text
    subject.blank? ? DEFAULT_SUBJECT : subject
  end
end
