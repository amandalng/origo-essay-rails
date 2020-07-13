# Preview all emails at http://localhost:3000/rails/mailers/essay_mailer
class EssayMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/essay_mailer/newSubmission
  def confirmation_and_payment
    EssayMailer.confirmation_and_payment
  end

  def new_submission
    EssayMailer.new_submission
  end

end
