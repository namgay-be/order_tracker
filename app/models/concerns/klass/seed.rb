module Klass
  module Seed
    extend ActiveSupport::Concern

    class_methods do
      def search(query)
        joins(:seed_info, :donor_info, :collection_info).where(
          "CONCAT_WS(
            ' ',
            seed_infos.crop_name,
            seed_infos.local_name,
            seed_infos.local_variety_name,
            seed_infos.classification,
            seed_infos.seed_status,
            donor_infos.dzongkhag,
            donor_infos.gewog,
            donor_infos.village,
            donor_infos.dungkhag,
            collection_infos.collection_number
          ) iLIKE ?",
          "%#{query&.squish}%"
        )
      end
    end
  end
end
