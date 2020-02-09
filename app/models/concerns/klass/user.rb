module Klass
  module User
    extend ActiveSupport::Concern

    class_methods do
      def search(query)
        where(
          "CONCAT_WS(
            ' ',
            users.email,
            users.name,
            users.username
          ) iLIKE ?",
          "%#{query&.squish}%"
        )
      end

      Role.names.keys.each do |role|
        define_method role do
          joins(:role).where(roles: { name: role })
        end
      end
    end
  end
end
