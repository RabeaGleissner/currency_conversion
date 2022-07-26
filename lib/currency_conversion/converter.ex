defmodule CurrencyConversion.Converter do
  alias CurrencyConversion.RequestHandler

  def get_historical_rate(from_currency, to_currency, date, amount) do
    url = "https://api.exchangerate.host/convert?from=#{from_currency}&to=#{to_currency}&date=#{date}&amount=#{amount}"
    case RequestHandler.get(url) do
      # {200, {:error, "JSON decode failed"}} write test for it
      {200, {:ok, %{info: %{rate: rate}, result: result}}} -> {:ok, converted_amount: result, rate: rate}
      {:error, reason} -> {:error, message: reason}
    end
  end
end

#{200, {:ok, %{date: "2022-07-23", historical: true, info: %{rate: 0.850677}, motd: %{msg: "If you...", url: "https://exchangerate.host/#/donate"}, query: %{amount: 1, from: "EUR", to: "GBP"}, result: 0.850677, success: true}}}
