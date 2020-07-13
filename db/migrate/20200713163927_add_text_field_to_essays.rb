class AddTextFieldToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :essays, :essay, :text
  end
end
