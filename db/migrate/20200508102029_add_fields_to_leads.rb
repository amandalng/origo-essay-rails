class AddFieldsToLeads < ActiveRecord::Migration[5.2]
  def change
    add_column :leads, :contacted, :boolean, default: false
    add_column :leads, :converted, :boolean, default: false
  end
end
