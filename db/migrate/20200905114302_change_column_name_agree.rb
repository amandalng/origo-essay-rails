class ChangeColumnNameAgree < ActiveRecord::Migration[5.2]
  def change
    rename_column :essays, :agree, :agreement
  end
end
