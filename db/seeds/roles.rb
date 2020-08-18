Role.destroy_all
[
  {
    id: 1,
    name: :admin
  },
  {
    id: 2,
    name: :desuup
  },
  {
    id: 3,
    name: :store_owner
  },
  {
    id: 4,
    name: :commoner
  }
].each do |role|
  Role.create!(role)
end
