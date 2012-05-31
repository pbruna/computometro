require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase

  test "total should return the json date" do
    VCR.use_cassette "FOLIO/ITLinux" do
      get :total, :format => :json
      assert_response :success
      assert(JSON.parse(response.body), "No es JSON")
    end
  end

end
