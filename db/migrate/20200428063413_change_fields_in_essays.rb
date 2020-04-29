class ChangeFieldsInEssays < ActiveRecord::Migration[5.2]
  def change
    change_column_default :essays, :received, true
    change_column_default :essays, :assigned, false
    change_column_default :essays, :reviewed, false
    change_column_default :essays, :meeting_scheduled, false
    change_column_default :essays, :completed, false

    rename_column :essays, :reviewer_assigned, :reviewer_name
  end
end
