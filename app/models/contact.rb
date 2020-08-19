class Contact < ApplicationRecord
  belongs_to :store, inverse_of: :contacts

  enum contact_type: { helper: 0, manager: 11 }
end
