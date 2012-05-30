class Deal < ActiveRecord::Base
  attr_accessible :currency, :highrise_id, :name, :price, :status
  Highrise::Base.format = :xml
  Highrise::Base.user = APP_CONFIG["highrise_token"]
  Highrise::Base.site = APP_CONFIG["highrise_site_url"]
  
  before_save :set_price_to_cero_if_nil

  def self.highrise_deals
    deals = Highrise::Deal.find(:all)
  end

  def self.convert_from_hr_to_deal(hr_deal)
    deal = Deal.where(:highrise_id => hr_deal.id).first_or_initialize(
      :name => hr_deal.name,
      :currency => hr_deal.currency,
      :price => hr_deal.price,
      :status => hr_deal.status,
    )
  end
  
  def self.sync_with_highrise!
    hr_deals = self.highrise_deals
    hr_deals.each do |hr_deal|
      deal = self.convert_from_hr_to_deal(hr_deal)
      deal.save
    end
  end
  
  def self.total_for(status)
    total = Deal.send(status + "_total")
    return 0 if total.nil?
    total
  end
  
  # Metaprograming defining XX_total methods
  %w(won lost pending).each do |status|
    method_name = (status + "_total").to_sym
    self.class.send(:define_method, method_name) do
      self.send(status).sum("price", :group => :currency)
    end
  end
  
  scope :won, -> {where(:status => "won")}
  scope :lost, -> {where(:status => "lost")}
  scope :pending, -> {where(:status => "pending")}
  
  private
  def set_price_to_cero_if_nil
    return unless price.nil?
    self.price = 0
  end
  
end
