class ApplicationMailer < ActionMailer::Base
  default from: "nickname@domain.com"
  layout 'mailer'
end
