class ChangeFieldNameInEssays < ActiveRecord::Migration[5.2]
  def change
    rename_column :essays, :essay_submission, :attachment
  end
end
