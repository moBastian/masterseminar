# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    StudentMailer.edited("test@test.com", "12kjk2j1k")
  end

end
