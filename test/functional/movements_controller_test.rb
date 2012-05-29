require 'test_helper'

class MovementsControllerTest < ActionController::TestCase
  test  "index should return json transactions" do
    get :index, :format => :json
    assert_response :success
    @movements = assigns(:movements)
    assert(JSON.parse(response.body), "No es JSON")
  end
  
  test "balance should return a json response with balance" do
    get :balance, :format => :json
    assert_response :success
    @balance = assigns(:balance)
    json = JSON.parse(response.body)
    assert_equal(json["balance"].class, Fixnum)
  end
  
end
