require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

  test "get_folio_totals should return JSON with totals" do
    VCR.use_cassette "FOLIO/ITLinux" do
      totals = Invoice.get_folio_totals
      assert_equal(totals.class, Hash)
    end
  end

end
