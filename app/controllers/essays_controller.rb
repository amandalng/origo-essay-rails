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
      # EssayMailer.with(essay: @essay).confirmation_and_payment.deliver_now
      EssayMailer.with(essay: @essay).new_submission.deliver_now
      redirect_to confirmation_essay_path(@essay)
    else
      redirect_to new_essay_path(@essay), notice: "Submission unsuccessful. Please try again, and fill all required fields."
    end
  end

  def index
    if current_user.administrator == true
      @essays = Essay.all.sort_by &:created_at
      respond_to do |format|
        format.html
        format.xlsx {
          response.headers['Content-Disposition'] = 'attachment; filename="all_essays.xlsx"'
        }
      end
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

  def download
    @essay = Essay.find(params[:id])

    respond_to do |format|
      format.docx {
        response.headers["Content-Disposition"] = "attachment; filename=\"#{@essay.date_submitted}_#{@essay.student_name}.docx\""
      }
    end
  end

  def edit
    @user = current_user
    @essay = Essay.find(params[:id])
    @reviewers = User.all.order(:full_name)

    @reviewer_names = []
    @reviewers.each do |reviewer|
      @reviewer_names << reviewer.full_name
    end
  end

  def update
    @essay = Essay.find(params[:id])

    if params["essay"].present?
      @user = User.find_by_full_name(params["essay"]["user"])
      @essay.user = @user
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

    if @essay.save
      redirect_to user_essays_path(current_user)
      if @essay.reviewed == false
        EssayMailer.with(essay: @essay).assign_reviewer.deliver_now
        # EssayMailer.with(essay: @essay).intro_reviewer.deliver_now
      # elsif @essay.reviewed == false

      # elsif @essay.assigned == false

      # elsif @essay.received == false

      end
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
    params.require(:essay).permit(:student_name, :email, :applicant_type, :country_applying, :university_applying, :program_applying, :prompt, :word_count, :notes, :attachment, :user, :essay, :agree)
  end
end
