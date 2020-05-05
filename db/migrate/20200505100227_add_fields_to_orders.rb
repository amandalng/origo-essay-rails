class AddFieldsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :student_name, :string
    add_column :orders, :email, :string
    add_column :orders, :applicant_type, :string
    add_column :orders, :country_applying, :string
    add_column :orders, :university_applying, :string
    add_column :orders, :program_applying, :string
    add_column :orders, :prompt, :string
    add_column :orders, :word_count, :integer
    add_column :orders, :notes, :text
  end
end
