class EssaysController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :confirmation, :pricing]

  def new
    @essay = Essay.new
    @lead = Lead.new
  end

  def create
    @essay = Essay.new(essay_params)
    if @essay.price_cents > 0
      @essay.price_cents = @essay.essay_price*100
    end

    if @essay.save
      redirect_to confirmation_essay_path(@essay), notice: "Submission successful!"
    else
      redirect_to new_essay_path(@essay), notice: "Submission unsuccessful. Please try again, and fill all required fields."
    end
  end

  def index
    if current_user.administrator == true
      @essays = Essay.all.sort_by &:created_at
    else
      @essays = Essay.where(user: current_user).sort_by &:created_at
    end
  end

  def show
    @essay = Essay.find(params[:id])
  end

  def confirmation
    @essay = Essay.find(params[:id])
  end

  def edit
    @user = current_user
    @essay = Essay.find(params[:id])
    @reviewers = User.all.order(:full_name)

    @reviewer_names = []
    @reviewers.each do |reviewer|
      @reviewer_names << reviewer.full_name
    end
    # raise
  end

  def update
    @essay = Essay.find(params[:id])

    if params["essay"].present?
      @essay.user = User.find_by_full_name(params["essay"]["user"])
      @essay.assigned = true
    elsif @essay.meeting_scheduled?
      @essay.completed = true
    elsif @essay.reviewed?
      @essay.meeting_scheduled = true
    elsif @essay.assigned?
      @essay.reviewed = true
    elsif @essay.received?
      @essay.assigned = true
    end
    @essay.save

    if @essay.save
      redirect_to user_essays_path(current_user)
    else
      render "edit"
    end
  end

  # def mark
  #   @essay = Essay.find(params[:id])
  #   if @essay.meeting_scheduled?
  #     @essay.completed = true
  #   elsif @essay.reviewed?
  #     @essay.meeting_scheduled = true
  #   elsif @essay.assigned?
  #     @essay.reviewed = true
  #   elsif @essay.received?
  #     @essay.assigned = true
  #   end
  #   @essay.save

  #   redirect_to user_essays_path(current_user)
  # end

  def pricing
  end

  private

  def essay_params
    params.require(:essay).permit(:student_name, :email, :applicant_type, :country_applying, :university_applying, :program_applying, :prompt, :word_count, :notes, :attachment, :user)
  end
end
