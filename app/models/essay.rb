class Essay < ApplicationRecord
  belongs_to :user, optional: true

  validates :student_name, presence: true, :length => { :minimum => 2 }
  validates :email, presence: true, :format => { :with => /[^@]+@[^\.]+\..+/,
    :message => "Please input a proper email" }
  validates :applicant_type, presence: true, :inclusion => { :in => %w(Undergraduate Graduate),
    :message => "Please select Undergraduate or Graduate" }
  validates :country_applying, presence: true, :inclusion => { :in => %w(US CA UK Other),
    :message => "Please select US, CA, UK, or Other" }
  validates :prompt, presence: true, :length => { :minimum => 2 }
  validates :word_count, presence: true, :numericality => { :greater_than_or_equal_to => 100, :message => "Essay must be greater than 100 words." }
  # validates :essay_submission, presence: true

  def essay_price
    if applicant_type == "Undergraduate"
      if word_count <= 250
        return 80
      elsif word_count <= 400
        return 110
      elsif word_count <= 600
        return 130
      else
        return 180
      end
    else
      if word_count <= 250
        return 90
      elsif word_count <= 400
        return 120
      elsif word_count <= 600
        return 150
      else
        return 200
      end
    end
  end

  def essay_status
    if completed?
      "Essay completed"
    elsif meeting_scheduled?
      "Meeting scheduled"
    elsif reviewed?
      "Essay reviewed"
    elsif assigned?
      "Reviewer assigned"
    else
      "Essay received"
    end
  end

  def next_step
    if completed?
      "Done!"
    elsif meeting_scheduled?
      "Mark meeting completed"
    elsif reviewed?
      "Mark meeting scheduled"
    elsif assigned?
      "Mark essay reviewed"
    else
      "Mark reviewer assigned"
    end
  end

  def date_submitted
    created_at.strftime("%Y-%m-%d, %H:%M")
  end

  def deadline
    (created_at + 5.days).strftime("%Y-%m-%d, %H:%M")
  end

  def reviewer_name
    user.full_name
  end
end
