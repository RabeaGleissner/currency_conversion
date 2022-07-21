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

#%{date: "2022-07-20", historical: true, info: %{rate: 1.017935}, motd: %{msg: "If you or your company use this project or like what we doing, please consider backing us so we can continue maintaining and evolving this project.", url: "https://exchangerate.host/#/donate"}, query: %{amount: 1, from: "EUR", to: "USD"}, result: 1.017935, success: true}
