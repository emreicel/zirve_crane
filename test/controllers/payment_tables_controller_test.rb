require "test_helper"

class PaymentTablesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get payment_tables_update_url
    assert_response :success
  end
end
