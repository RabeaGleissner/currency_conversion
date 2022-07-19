defmodule CurrencyConversion.Converter do
  alias CurrencyConversion.RequestHandler

  def get_historical_rate(from_currency, to_currency, date, amount) do
    url = "https://api.exchangerate.host/convert?from=#{from_currency}&to=#{to_currency}&date=#{date}&amount=#{amount}"
    case RequestHandler.get(url) do
      {200, %{result: result}} -> {:ok, converted_amount: result}
      {:error, _} -> {:error,  message: "There was an error"}
    end
  end
end
