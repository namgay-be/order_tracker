require_relative './../migrations/base'
require_relative './../migrations/user'
require_relative './../migrations/customer'
require_relative './../migrations/dzongkhag'
require_relative './../migrations/gewog'
require_relative './../migrations/donor'
require_relative './../migrations/donor_field'
require_relative './../migrations/seed'
require_relative './../migrations/collection'
require_relative './../migrations/cultivation'
require_relative './../migrations/repatriation'
require_relative './../migrations/repatriation_info'
require_relative './../migrations/test'
require_relative './../migrations/gene_bank'
require_relative './../migrations/distribution'

namespace :userdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'user_info.csv'))
    Migrations::User.new(user_csv).run
  end
end

namespace :customerdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'customer_info.csv'))
    Migrations::Customer.new(user_csv).run
  end
end

namespace :dzongkhagdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'dzongkhag_info.csv'))
    Migrations::Dzongkhag.new(user_csv).run
  end
end

namespace :gewogdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'gewog_info.csv'))
    Migrations::Gewog.new(user_csv).run
  end
end

namespace :donordata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'donor_info.csv'))
    Migrations::Donor.new(user_csv).run
  end
end

namespace :donorfielddata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'donorfield_info.csv'))
    Migrations::DonorField.new(user_csv).run
  end
end

namespace :seeddata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'seed_info.csv'))
    Migrations::Seed.new(user_csv).run
  end
end

namespace :collectiondata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'collection_info.csv'))
    Migrations::Collection.new(user_csv).run
  end
end

namespace :cultivationdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'cultivation_info.csv'))
    Migrations::Cultivation.new(user_csv).run
  end
end

namespace :repatriationdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'repatriationsource_info.csv'))
    Migrations::Repatriation.new(user_csv).run
  end
end

namespace :repatriationinfodata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'repatriation_info.csv'))
    Migrations::RepatriationInfo.new(user_csv).run
  end
end

namespace :testdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'test_info.csv'))
    Migrations::Test.new(user_csv).run
  end
end

namespace :genebankdata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'genebank_seeds.csv'))
    Migrations::GeneBank.new(user_csv).run
  end
end

namespace :distributiondata do
  task migrate: :environment do
    user_csv = File.read(Rails.root.join('lib', 'csvs', 'distribution_info.csv'))
    Migrations::Distribution.new(user_csv).run
  end
end
