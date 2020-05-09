class AddNotesToLeads < ActiveRecord::Migration[5.2]
  def change
    add_column :leads, :notes, :text
  end
end
