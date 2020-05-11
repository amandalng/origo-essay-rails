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

  def show
    @lead = Lead.find(params[:id])
  end

  def edit
    @lead = Lead.find(params[:id])
    @administrators = User.where(administrator: true)

    @administrator_names = []
    @administrators.each do |administrator|
      @administrator_names << administrator.full_name
    end
  end

  def update
    @lead = Lead.find(params[:id])
    if params["lead"].present?
      if @lead.user.nil?
        @lead.user = User.find_by_full_name(params["lead"]["user"])
        if @lead.save
          redirect_to user_leads_path(current_user)
        else
          render "edit"
        end
      elsif @lead.notes.nil?
        @lead.notes = params["lead"]["notes"]
        if @lead.save
          redirect_to user_lead_path(current_user, @lead)
        else
          render "edit"
        end
      end
    elsif @lead.contacted?
      @lead.converted = true
      @lead.save

      redirect_to user_leads_path(current_user)
    else
      @lead.contacted = true
      @lead.save

      redirect_to user_leads_path(current_user)
    end

  end

  private

  def lead_params
    params.require(:lead).permit(:full_name, :email, :phone)
  end
end
