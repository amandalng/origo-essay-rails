class LeadsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to root_path, notice: "We'll be in touch!"
    else
      redirect_to new_essay_path, notice: "Please provide your full name and email address."
    end
  end

  def index
    @leads = Lead.all.sort_by &:created_at
  end

  def update
    @lead = Lead.find(params[:id])
    if @lead.contacted?
      @lead.converted = true
    else
      @lead.contacted = true
    end
    @lead.save

    redirect_to user_leads_path(current_user)
  end

  private

  def lead_params
    params.require(:lead).permit(:full_name, :email, :phone)
  end
end
