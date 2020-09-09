class EssayMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.essay_mailer.newSubmission.subject
  #
  def new_submission
    @admin_emails = []
    User.all.each do |user|
      if user.administrator == true
        @admin_emails << user.email
      end
    end
    @essay = params[:essay]
    attachments["#{@essay.date_submitted_filename}_#{@essay.student_name}.doc"] = {
      :mime_type => 'application/doc',
      :content => @essay.essay
    }
    mail(
      to: @admin_emails,
      subject: "#{@essay.student_name} just submitted an essay!"
      )
  end

  def confirmation_and_payment
    # @admin_emails = []
    # User.all.each do |user|
    #   if user.administrator == true
    #     @admin_emails << user.email
    #   end
    # end
    @essay = params[:essay]
    attachments["#{@essay.date_submitted_filename}_#{@essay.student_name}.doc"] = {
      :mime_type => 'application/doc',
      :content => @essay.essay
    }
    mail(
      to: @essay.email,
      subject: "Origo Essays: We have received your submission!"
      )
  end

  def assign_reviewer
    @admin_emails = []
    User.all.each do |user|
      if user.administrator == true
        @admin_emails << user.email
      end
    end
    @essay = params[:essay]
    attachments["#{@essay.date_submitted_filename}_#{@essay.student_name}.doc"] = {
      :mime_type => 'application/doc',
      :content => @essay.essay
    }
    mail(
      to: @essay.user.email,
      bcc: @admin_emails,
      subject: "Origo Essays: You've been assigned an essay!"
      )
  end

  def intro_reviewer
    @admin_emails = []
    User.all.each do |user|
      if user.administrator == true
        @admin_emails << user.email
      end
    end
    @essay = params[:essay]

    mail(
      to: @essay.email,
      cc: @essay.user.email,
      bcc: @admin_emails,
      subject: "Origo Essays: Meet your editor!"
      )
  end
end
