class ApplicationMailer < ActionMailer::Base
  #Senden der Mail von der E-Mail-Adresse
  #mit dem layout
  #TODO neue Mailadresse einfügen
  default from: 'stu114712@mail.uni-kiel.de'
  layout 'mailer'
end

