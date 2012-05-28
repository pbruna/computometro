class Movement < ActiveRecord::Base
  attr_accessible :date, :income, :subject, :total
  before_create :set_movement_type #income or outcome
  before_create :calculate_md5sum
  
  validates_presence_of :date, :total, :subject
  
  
  def self.sync_with_bank!
    bank_credentials = {
      :user => APP_CONFIG['user_rut'],
      :password => APP_CONFIG['user_password'],
      :company_rut => APP_CONFIG['company_rut'],
      :number => APP_CONFIG['company_account']
    }
    bank = Bank.new("CHILEEMPRESAS", bank_credentials)
    transactions = bank.transactions.reverse
    balance = bank.balance
    transactions.each do |transaction|
      movement = Movement.new(
        :total => transaction.total,
        :subject => transaction.description,
        :date => transaction.date
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
    string = total.to_s + subject + date.to_s + income.to_s
    self.checksum = Digest::MD5.hexdigest(string)
    return false if Movement.find_by_checksum(self.checksum)
  end
  
end
