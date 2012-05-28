# encoding: utf-8
namespace :computometro do
  
  desc "Sincroniza balance y movimientos del banco"
  task :sync_bank_info => :environment do
    bank_credentials = {
      :user => APP_CONFIG['user_rut'],
      :password => APP_CONFIG['user_password'],
      :company_rut => APP_CONFIG['company_rut'],
      :number => APP_CONFIG['company_account']
    }
    bank = Bank.new("CHILEEMPRESAS", bank_credentials)
    puts bank.transactions
  end
  
end