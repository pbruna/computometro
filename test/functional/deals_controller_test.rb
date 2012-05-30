require 'test_helper'

class DealsControllerTest < ActionController::TestCase
  
  test  "index should return json transactions" do
    get :index, :format => :json
    assert_response :success
    deals = assigns(:deals)
    assert(JSON.parse(response.body), "No es JSON")
  end
  
  test "total should return a total based on the status param" do
    sync_deals
    get :total, :status => 'won', :format => :json
    assert_response :success
    usd = JSON.parse(response.body)["total"]['USD']
    clp = JSON.parse(response.body)["total"]['CLP']
    assert_equal(usd.class, Fixnum)
    assert_equal(clp.class, Fixnum)
  end
  
end
