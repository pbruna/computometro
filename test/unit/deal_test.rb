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

  test "return total for each status of the deal" do
    assert(Deal.pending_total)
    assert(Deal.lost_total)
    assert(Deal.won_total)
  end

  test "return_total_for" do
    assert(Deal.total_for("pending"))
    assert(Deal.total_for("lost"))
    assert(Deal.total_for("won"))
  end

  test "set price to 0 if is nil" do
    deal = Deal.new(
      :highrise_id => 2020,
      :name => "zimbra project",
      :currency => "USD",
      :price => nil,
      :status => "pending"
    )
    deal.save
    assert_equal(0, deal.price)
  end
end
