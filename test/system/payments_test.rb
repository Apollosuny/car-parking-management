require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase
  setup do
    @payment = payments(:one)
  end

  test "visiting the index" do
    visit payments_url
    assert_selector "h1", text: "Payments"
  end

  test "should create payment" do
    visit payments_url
    click_on "New payment"

    fill_in "Note", with: @payment.note
    fill_in "Paymenttype", with: @payment.paymentType
    check "Status" if @payment.status
    fill_in "Totaltime", with: @payment.totalTime
    click_on "Create Payment"

    assert_text "Payment was successfully created"
    click_on "Back"
  end

  test "should update Payment" do
    visit payment_url(@payment)
    click_on "Edit this payment", match: :first

    fill_in "Note", with: @payment.note
    fill_in "Paymenttype", with: @payment.paymentType
    check "Status" if @payment.status
    fill_in "Totaltime", with: @payment.totalTime
    click_on "Update Payment"

    assert_text "Payment was successfully updated"
    click_on "Back"
  end

  test "should destroy Payment" do
    visit payment_url(@payment)
    click_on "Destroy this payment", match: :first

    assert_text "Payment was successfully destroyed"
  end
end
