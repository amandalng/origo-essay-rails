class AddSpamColumnToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :essays, :spam, :boolean
  end
end
