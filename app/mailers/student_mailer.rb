class StudentMailer < ApplicationMailer

  def edited(email, code)
    @code = code
    mail(to: email, subject: 'Ihre Zugangsdaten für Probename')
  end

  def notifyAll(email, code)
    @code = code
    mail(to:email, subject: "Probieren doch nochmal 1-2 Tests :)")
  end

end
