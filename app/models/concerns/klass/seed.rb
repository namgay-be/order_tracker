module Klass
  module Seed
    extend ActiveSupport::Concern

    class_methods do
      def search(query)
        joins(:seed_info, :collection_info, donor_info: { gewog: :dzongkhag}).where(
          "CONCAT_WS(
            ' ',
            seeds.crop_name,
            seed_infos.local_name,
            seed_infos.local_variety_name,
            seeds.classification,
            seeds.seed_status,
            dzongkhags.name,
            gewogs.name,
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
