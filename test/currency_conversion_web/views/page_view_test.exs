defmodule CurrencyConversionWeb.PageViewTest do
  use CurrencyConversionWeb.ConnCase, async: true
  alias CurrencyConversionWeb.PageView

  test "Formats amount with two decimals" do
    assert PageView.format_amount(98.237989) == "98.24"
  end

  test "Returns empty string if the amount is not a float" do
    assert PageView.format_amount("") == ""
  end
end
