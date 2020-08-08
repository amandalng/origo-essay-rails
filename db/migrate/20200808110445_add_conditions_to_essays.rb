class AddConditionsToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :essays, :agree, :boolean
  end
end
