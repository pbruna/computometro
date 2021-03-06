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
  
  test "total should return a json with balance and [income, outcome]" do
    get :total, :format => :json
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal(Fixnum, json["total"]["balance"].class)
    assert_equal(Fixnum, json["total"]["income"].class)
    assert_equal(Fixnum, json["total"]["outcome"].class)
  end
  
end
