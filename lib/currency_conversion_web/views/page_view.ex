defmodule CurrencyConversionWeb.PageView do
  use CurrencyConversionWeb, :view

  def format_amount(amount) do
    case is_float(amount) || is_integer(amount) do
      true -> :erlang.float_to_binary(amount/1, [decimals: 2])
      false -> ""
    end
  end

  def format_error_message(is_error) do
    case is_error do
      true -> "Apologies, there was an error!"
      _ -> ""
    end
  end

  def uppercase(string) do
    String.upcase(string)
  end
end
