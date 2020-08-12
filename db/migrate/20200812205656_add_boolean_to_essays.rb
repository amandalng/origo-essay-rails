class AddBooleanToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :essays, :invoice_sent, :boolean
    add_column :essays, :payment_received, :boolean
  end
end
