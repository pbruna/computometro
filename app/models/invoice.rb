class Invoice < ActiveResource::Base
  self.site = APP_CONFIG["folio_url"]
  self.user = APP_CONFIG["folio_user"]
  self.password = APP_CONFIG["folio_password"]

  def self.get_folio_totals
    get(:totals)
  end

end
