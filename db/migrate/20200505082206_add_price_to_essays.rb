class AddPriceToEssays < ActiveRecord::Migration[5.2]
  def change
    add_monetize :essays, :price, currency: { presence: false}
  end
end
