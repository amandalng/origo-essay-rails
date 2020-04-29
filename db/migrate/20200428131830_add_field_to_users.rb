class AddFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :administrator, :boolean, default: false
  end
end
