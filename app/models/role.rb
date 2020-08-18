class Role < ApplicationRecord
  has_many :users, inverse_of: :role

  enum name: { admin: 0, desuup: 3, store_owner: 6, commoner: 9 }
end
