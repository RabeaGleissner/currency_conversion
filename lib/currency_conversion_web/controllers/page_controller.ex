defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller
  alias CurrencyConversion.Converter
  alias CurrencyConversion.ApiCache

  def index(conn, _params) do
    amount_from_session = get_session(conn, :converted_amount)
    converted_amount = if amount_from_session, do: amount_from_session, else: ""
    is_error = get_session(conn, :error)

    conn
    |> put_session(:converted_amount, nil)
    |> put_session(:error, nil)
    |> render("index.html", %{converted_amount: converted_amount, error: is_error})
  end

  def convert(conn, %{"amount" => input_amount, "from" => from, "to" => to, "date" => date}) do
    {amount_as_float, ""} = Float.parse(input_amount)
    amount = amount_as_float * 100
    result = case rate_cached?(from<>to, date) do
      {:ok, %{rate: rate}} -> calculate_result(rate, amount)
      {:empty} -> handle_api_call(from, to, date, amount/100)
    end

    conn
    |> update_session(result)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp update_session(conn, {:ok, converted_amount: converted_amount }) do
    conn
    |> put_session(:converted_amount, converted_amount)
  end

  defp update_session(conn, {:error, message: _}) do
    conn
    |> put_session(:error, true)
  end

  defp rate_cached?(key, date) do
    rate = ApiCache.retrieve(key, date)
    if rate do
      {:ok, %{rate: 100000000000}}
    else
      {:empty}
    end
  end

  defp handle_api_call(from, to, date, amount) do
    result = Converter.get_historical_rate(from, to, date, amount)
    placeholder_rate = 5
    case result do
      {:ok, converted_amount: converted_amount} ->
        ApiCache.insert(from<>to, date, placeholder_rate)
        {:ok, converted_amount: converted_amount}
      {:error, _} -> {:error, true}
    end
  end

  defp calculate_result(rate, amount) do
    converted_amount = (rate * amount)/100
    {:ok, converted_amount: converted_amount}
  end
end
