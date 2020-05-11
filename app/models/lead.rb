class Lead < ApplicationRecord
  validates :full_name, presence: true
  validates :email, presence: true, :format => { :with => /[^@]+@[^\.]+\..+/,
    :message => "must be in proper format (e.g. john@gmail.com)" }

  belongs_to :user, optional: true

  def current_status
    if converted?
      "Converted to customer"
    elsif contacted?
      "Already contacted"
    else
      "Needs to be contacted"
    end
  end

  def next_step
    if converted?
      "Done"
    elsif contacted?
      "Mark contact converted"
    else
      "Contact lead"
    end
  end

  def date_submitted
    created_at.strftime("%Y-%m-%d")
  end
end
