class AddDiscountCodeToEssays < ActiveRecord::Migration[5.2]
  def change
    add_column :essays, :discountcode, :string
  end
end
