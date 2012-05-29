class Movement < ActiveRecord::Base
  attr_accessible :date, :income, :subject, :total, :balance
  before_create :set_movement_type #income or outcome
  before_create :calculate_md5sum
  
  validates_presence_of :date, :total, :subject
  
  def self.balance
    return 0 if last.nil?
    last.balance
  end
  
  def self.sync_with_bank!
    bank = self.bank_connection
    transactions = bank.transactions.reverse
    balance = bank.balance
    transactions.each do |transaction|
      movement = Movement.new(
        :total => transaction.total,
        :subject => transaction.description,
        :date => transaction.date,
        :balance => transaction.saldo
      )
      movement.save
    end
  end
  
  private
  def set_movement_type
    self.income = total > 0
    true
  end
  
  def calculate_md5sum
    string = total.to_s + subject + date.to_s + income.to_s + balance.to_s
    self.checksum = Digest::MD5.hexdigest(string)
    return false if Movement.find_by_checksum(self.checksum)
  end
  
  def self.bank_connection
    bank_credentials = {
      :user => APP_CONFIG['user_rut'],
      :password => APP_CONFIG['user_password'],
      :company_rut => APP_CONFIG['company_rut'],
      :number => APP_CONFIG['company_account']
    }
    bank = Bank.new("CHILEEMPRESAS", bank_credentials)
    bank
  end
  
end
