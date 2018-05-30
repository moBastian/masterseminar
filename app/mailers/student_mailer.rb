class StudentMailer < ApplicationMailer

  #Senden der Mail, wenn ein Proband sich die Zugangsdaten zusendet
  def edited(email, code)
    @code = code
    mail(to: email, subject: 'Ihre Zugangsdaten für Quizmos')
  end

  #Rundmail an alle Nutzer
  def notifyAll(email, code)
    @code = code
    mail(to:email, subject: "Probieren doch nochmal 1-2 Tests :)")
  end

end
