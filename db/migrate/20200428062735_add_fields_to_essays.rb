class AddFieldsToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :essays, :student_name, :string
    add_column :essays, :email, :string
    add_column :essays, :applicant_type, :string
    add_column :essays, :country_applying, :string
    add_column :essays, :university_applying, :string
    add_column :essays, :program_applying, :string
    add_column :essays, :prompt, :string
    add_column :essays, :word_count, :string
    add_column :essays, :essay_submission, :string
    add_column :essays, :notes, :string
    add_column :essays, :reviewer_assigned, :string
    add_column :essays, :received, :boolean
    add_column :essays, :assigned, :boolean
    add_column :essays, :reviewed, :boolean
    add_column :essays, :meeting_scheduled, :boolean
    add_column :essays, :completed, :boolean
  end
end
