class EssaysController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :confirmation]

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
      @essays = Essay.all
    else
      @essays = Essay.where(user: current_user)
    end
  end

  def show
    @essay = Essay.find(params[:id])
  end

  def edit
  end

  def update
  end

  def confirmation
    @essay = Essay.find(params[:id])
  end

  def assign_reviewer

  end

  private

  def essay_params
    params.require(:essay).permit(:student_name, :email, :applicant_type, :country_applying, :university_applying, :program_applying, :prompt, :word_count, :notes, :attachment)
  end
end
