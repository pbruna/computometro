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

  test "Deal.convert_from_hr_to_deal should return a Deal instance" do
    deals = nil
    VCR.use_cassette "HIGHRISE/ITLinux" do
      deals = Deal.highrise_deals
      deal = Deal.convert_from_hr_to_deal(deals.last)
      assert_equal(Deal, deal.class)
    end
  end

  test "Deal.sync_with_highrise! should sync the deals with the db" do
    VCR.use_cassette "HIGHRISE/ITLinux_Sync" do
      hr_deal = Deal.highrise_deals.last
      deals = Deal.sync_with_highrise!
      assert(Deal.find_by_highrise_id(hr_deal.id), "Deal not found")
    end
  end

  test "return only the wons deal" do
    sync_deals
    won_deals = Deal.won
    status = won_deals.last.status
    assert_equal("won", won_deals.first.status)
  end
  
  test "return only the lost deal" do
    sync_deals
    lost_deals = Deal.lost
    status = lost_deals.last.status
    assert_equal("lost", lost_deals.first.status)
  end
  
  test "return only the pending deal" do
    sync_deals
    pending_deals = Deal.pending
    status = pending_deals.last.status
    assert_equal("pending", pending_deals.first.status)
  end

  private
    def sync_deals
      VCR.use_cassette "HIGHRISE/ITLinux_Sync" do
        hr_deal = Deal.highrise_deals.last
        deals = Deal.sync_with_highrise!
      end
    end

end
