class LeadMailer < ApplicationMailer
  def new_lead
    @admin_emails = []
    User.all.each do |user|
      if user.administrator == true
        @admin_emails << user.email
      end
    end
    @lead = params[:lead]
    mail(
      to: @admin_emails,
      subject: "#{@lead.full_name} just made an inquiry!"
      )
  end
end
