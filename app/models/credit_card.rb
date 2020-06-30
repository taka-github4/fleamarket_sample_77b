class CreditCard < ApplicationRecord
  belongs_to :user
  validates :customer_id, length: { is: 32 },format:{with:/cus\_[a-f0-9]{28}/}
  validates :card_id,length: { is: 32 },format:{with:/car\_[a-f0-9]{28}/}
end