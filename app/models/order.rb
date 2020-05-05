class Order < ApplicationRecord
  belongs_to :essay

  monetize :amount_cents
end
