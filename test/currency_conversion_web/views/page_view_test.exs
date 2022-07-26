defmodule CurrencyConversionWeb.PageViewTest do
  use CurrencyConversionWeb.ConnCase, async: true
  alias CurrencyConversionWeb.PageView

  test "Formats float amount with two decimals" do
    assert PageView.format_amount(98.237989) == "98.24"
  end

  test "Formats integer amount with two decimals" do
    assert PageView.format_amount(120) == "120.00"
  end

  test "Returns empty string if the amount is not a float" do
    assert PageView.format_amount("") == ""
  end

  test "Formats error message when there is one" do
    assert PageView.format_error_message(true) == "Apologies, there was an error!"
  end

  test "Returns epmty string for error when there is none" do
    assert PageView.format_error_message(nil) == ""
  end
end
