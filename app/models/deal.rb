class Deal < ActiveRecord::Base
  attr_accessible :currency, :highrise_id, :name, :price, :status
  Highrise::Base.format = :xml
  Highrise::Base.user = APP_CONFIG["highrise_token"]
  Highrise::Base.site = APP_CONFIG["highrise_site_url"]
  
  def self.highrise_deals
    deals = Highrise::Deal.find(:all)
  end
  
end
