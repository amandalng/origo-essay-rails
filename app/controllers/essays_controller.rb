class EssaysController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :confirmation, :pricing]

  def new
    @essay = Essay.new
  end

  def create
    @essay = Essay.new(essay_params)

    if @essay.save
      redirect_to confirmation_essay_path(@essay), notice: "Successfully uploaded."
    else
      render "new"
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

  def pricing
  end

  def mark
    @essay = Essay.find(params[:id])
    if @essay.meeting_scheduled?
      @essay.completed = true
    elsif @essay.reviewed?
      @essay.meeting_scheduled = true
    elsif @essay.assigned?
      @essay.reviewed = true
    elsif @essay.received?
      @essay.assigned = true
    end
    @essay.save

    redirect_to user_essays_path(current_user)
  end

  private

  def essay_params
    params.require(:essay).permit(:student_name, :email, :applicant_type, :country_applying, :university_applying, :program_applying, :prompt, :word_count, :notes, :attachment)
  end
end
