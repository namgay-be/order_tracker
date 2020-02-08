class Role < ApplicationRecord
  has_many :users, inverse_of: :role

  enum name: { admin: 0, moderator: 3 }
end
