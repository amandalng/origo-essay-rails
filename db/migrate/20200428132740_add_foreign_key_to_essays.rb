class AddForeignKeyToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string

    add_reference :essays, :user, foreign_key: true
    remove_column :essays, :reviewer_name
  end
end
