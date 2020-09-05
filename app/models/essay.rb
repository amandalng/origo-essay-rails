class Essay < ApplicationRecord
  belongs_to :user, optional: true

  validates :student_name, presence: true
  validates :email, presence: true, :format => { :with => /[^@]+@[^\.]+\..+/,
    :message => "must be in proper format (e.g. john@gmail.com)" }
  validates :applicant_type, presence: true, :inclusion => { :in => %w(Undergraduate Graduate) }
  validates :country_applying, presence: true, :inclusion => { :in => %w(US CA UK Other) }
  validates :prompt, presence: true, :length => { :minimum => 2 }
  validates :word_count, presence: true, :numericality => { :greater_than_or_equal_to => 100 }
  validates :essay, presence: true
  validates :agreement, presence: { message: "must be checked."}
  validates :discountcode, :inclusion => { :in => ["", "ORIGOESSAY25", "FRIENDSOFORIGO"] }

  mount_uploader :attachment, AttachmentUploader
  # validates :attachment, presence: true

  monetize :price_cents

  def essay_price
    if word_count.present?
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
  end

  def essay_status
    if completed?
      "Essay completed"
    elsif meeting_scheduled?
      "Meeting scheduled"
    elsif reviewed?
      "Essay reviewed"
    elsif assigned?
      "Editor assigned"
    elsif payment_received?
      "Payment received"
    elsif invoice_sent?
      "Invoice sent"
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
    elsif payment_received?
      "Assign editor"
    elsif invoice_sent?
      "Mark payment received"
    else
      "Mark invoice sent"
    end
  end

  def date_submitted
    created_at.strftime("%e %B, %Y")
  end

  def payment_deadline
    (created_at + 2.days).strftime("%e %B, %Y")
  end

  def review_deadline
    (updated_at + 2.days).strftime("%e %B, %Y")
  end


  def deadline
    (created_at + 5.days).strftime("%e %B, %Y")
  end

  def reviewer_name
    if assigned?
      user.full_name
    end
  end
end
