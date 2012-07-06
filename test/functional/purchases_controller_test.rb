require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post :create, purchase: { annotation: @purchase.annotation, item_id: @purchase.item_id, item_value: @purchase.item_value, payment_type: @purchase.payment_type, status: @purchase.status, transaction_date: @purchase.transaction_date, transaction_id: @purchase.transaction_id }
    end

    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should show purchase" do
    get :show, id: @purchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase
    assert_response :success
  end

  test "should update purchase" do
    put :update, id: @purchase, purchase: { annotation: @purchase.annotation, item_id: @purchase.item_id, item_value: @purchase.item_value, payment_type: @purchase.payment_type, status: @purchase.status, transaction_date: @purchase.transaction_date, transaction_id: @purchase.transaction_id }
    assert_redirected_to purchase_path(assigns(:purchase))
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete :destroy, id: @purchase
    end

    assert_redirected_to purchases_path
  end
end
