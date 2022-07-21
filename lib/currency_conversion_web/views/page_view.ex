defmodule CurrencyConversionWeb.PageView do
  use CurrencyConversionWeb, :view

  def format_amount(amount) do
    case is_float(amount) do
      true -> :erlang.float_to_binary(amount, [decimals: 2])
      false -> ""
    end
  end
end
