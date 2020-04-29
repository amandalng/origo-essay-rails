class ChangeMoreFieldsInEssays < ActiveRecord::Migration[5.2]
  def change
    change_column :essays, :notes, :text, using: 'notes::text'
    change_column :essays, :prompt, :text, using: 'prompt::text'
  end
end
