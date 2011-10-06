require 'test_helper'

class CustInfsControllerTest < ActionController::TestCase
  setup do
    @cust_inf = cust_infs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cust_infs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cust_inf" do
    assert_difference('CustInf.count') do
      post :create, :cust_inf => @cust_inf.attributes
    end

    assert_redirected_to cust_inf_path(assigns(:cust_inf))
  end

  test "should show cust_inf" do
    get :show, :id => @cust_inf.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cust_inf.to_param
    assert_response :success
  end

  test "should update cust_inf" do
    put :update, :id => @cust_inf.to_param, :cust_inf => @cust_inf.attributes
    assert_redirected_to cust_inf_path(assigns(:cust_inf))
  end

  test "should destroy cust_inf" do
    assert_difference('CustInf.count', -1) do
      delete :destroy, :id => @cust_inf.to_param
    end

    assert_redirected_to cust_infs_path
  end
end
