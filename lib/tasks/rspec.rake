namespace :rspec do
  task seed: :environment do
    load File.join(Rails.root, 'db', 'seeds', 'roles.rb')
  end
end
