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
    deal = Deal.where(:highrise_id => hr_deal.id).first
    if deal
      deal.name = hr_deal.name
      deal.currency = hr_deal.currency
      deal.price = hr_deal.price
      deal.status = hr_deal.status
      deal.author_id = hr_deal.author_id
      deal.status_changed_on = hr_deal.status_changed_on
      deal.highrise_created_at = hr_deal.created_at
    else
      deal = Deal.new(:highrise_id => hr_deal.id,
                      :name => hr_deal.name,
                      :currency => hr_deal.currency,
                      :price => hr_deal.price,
                      :status => hr_deal.status,
                      :author_id => hr_deal.author_id,
                      :status_changed_on => hr_deal.status_changed_on,
                      :highrise_created_at => hr_deal.created_at
                      )
    end
    deal
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
  
  def self.group_by_month_on_created(since_months_ago)
    deals = usd_to_clp(Deal.months_ago(since_months_ago).order("highrise_created_at asc"))
    deals.to_a.group_by {|d| d.highrise_created_at.month}
  end
  
  def self.created_by_month(months_ago)
    hash = Hash.new
    group_by_month_on_created(months_ago).each do |key, value|
      date = value.first.highrise_created_at.strftime("%m/%y")
      hash[date] = {:size => value.size, :total => value.sum(&:price)}
    end
    hash
  end
  
  def self.won_by_month(months_ago)
    hash = Hash.new
    won.group_by_month_on_created(months_ago).each do |key, value|
      date = value.first.highrise_created_at.strftime("%m/%y")
      hash[date] = {:size => value.size, :total => value.sum(&:price)}
    end
    hash
  end
  
  def self.lost_by_month(months_ago)
    hash = Hash.new
    lost.group_by_month_on_created(months_ago).each do |key, value|
      date = value.first.highrise_created_at.strftime("%m/%y")
      hash[date] = {:size => value.size, :total => value.sum(&:price)}
    end
    hash
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
  scope :months_ago, ->(months)  {where("highrise_created_at >= ?", Time.now.months_ago(months + 1).end_of_month + 1)}
  scope :with_currency, ->(currency) {where(:currency => currency)}

  private
    def set_price_to_cero_if_nil
      return unless price.nil?
      self.price = 0
    end
    
    def self.usd_to_clp(array)
      array.each do |d|
        if d.currency == "USD"
          d.price = d.price * 500
        end
      end
      array
    end

end
