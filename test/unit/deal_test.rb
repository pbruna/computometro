require 'test_helper'

class DealTest < ActiveSupport::TestCase
  test "highrise_deals should get the deals from highrise" do
    deals = nil
    VCR.use_cassette "HIGHRISE/ITLinux" do
      deals = Deal.highrise_deals
      assert_equal(deals.class, Array)
      assert(deals.last.respond_to?("price"), "No se esta cargando deals")
    end
  end
end
