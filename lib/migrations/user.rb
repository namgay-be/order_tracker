module Migrations
  class User < Base
    def run
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        user = set_user(hash)
        user.save!
      end
      puts 'Success'
    end

    private

    def set_user(hash)
      ::User.new(
        id: hash[:user_id],
        name: hash[:name],
        designation: hash[:designation],
        email: "dummy#{hash[:user_id]}@gmail.com",
        password: "dcpl1997",
        role_id: role(hash),
        invitation_accepted_at: DateTime.current
      )
    end

    def role(hash)
      hash[:role] == 'Admin' ? 1 : 2
    end
  end
end
