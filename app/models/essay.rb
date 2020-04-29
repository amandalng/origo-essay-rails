class Essay < ApplicationRecord
  belongs_to :user, optional: true

  validates :student_name, presence: true, :length => { :minimum => 2 }
  validates :email, presence: true, :format => { :with => /[^@]+@[^\.]+\..+/,
    :message => "must be in proper format (e.g. john@mgmail.com)" }
  validates :applicant_type, presence: true, :inclusion => { :in => %w(Undergraduate Graduate) }
  validates :country_applying, presence: true, :inclusion => { :in => %w(US CA UK Other) }
  validates :prompt, presence: true, :length => { :minimum => 2 }
  validates :word_count, presence: true, :numericality => { :greater_than_or_equal_to => 100 }
  # validates :essay_submission, presence: true

  mount_uploader :attachment, AttachmentUploader
  validates :attachment, presence: true

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
      "Done"
    elsif meeting_scheduled?
      "Mark meeting completed"
    elsif reviewed?
      "Mark meeting scheduled"
    elsif assigned?
      "Mark essay reviewed"
    else
      "Assign reviewer"
    end
  end

  def date_submitted
    created_at.strftime("%Y-%m-%d")
  end

  def deadline
    (created_at + 5.days).strftime("%Y-%m-%d")
  end

  def reviewer_name
    user.full_name
  end
end
