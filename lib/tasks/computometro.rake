# encoding: utf-8
namespace :computometro do
  
  desc "Sincroniza balance y movimientos del banco"
  task :sync_bank => :environment do
    Movement.sync_with_bank!
  end
  
  desc "Sincroniza Deals de HighRise"
  task  :sync_hr => :environment do
    Deal.sync_with_highrise!
  end
  
end