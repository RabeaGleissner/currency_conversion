defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller
  alias CurrencyConversion.Converter
  alias CurrencyConversion.ApiCache

  def index(conn, _params) do
    converted_amount = conn
                       |> get_session(:converted_amount)
                       |> case do
                         nil -> ""
                         existing_amount -> existing_amount
                       end
    is_error = get_session(conn, :error)

    conn
    |> put_session(:converted_amount, nil)
    |> put_session(:error, nil)
    |> render("index.html", %{converted_amount: converted_amount, error: is_error})
  end

  def convert(conn, %{"amount" => input_amount, "from" => from, "to" => to, "date" => date}) do
    {amount_as_float, ""} = Float.parse(input_amount)

    result = case rate_cached?(from<>to, date) do
      {:ok, %{rate: rate}} -> calculate_result(rate, amount_as_float * 100)
      {:empty} -> handle_api_call(from, to, date, amount_as_float)
    end

    conn
    |> update_session(result)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp rate_cached?(key, date) do
    cache_result = ApiCache.retrieve(key, date)
    if Enum.empty?(cache_result) do
      {:empty}
    else
      [rate] = cache_result
      {:ok, %{rate: rate}}
    end
  end

  defp handle_api_call(from, to, date, amount) do
    Converter.get_historical_rate(from, to, date, amount)
    |> case do
      {:ok, converted_amount: converted_amount, rate: rate} ->
        ApiCache.insert(from<>to, date, rate)
        {:ok, converted_amount: converted_amount}
      {:error, message: message} -> {:error, message: message}
    end
  end

  defp calculate_result(rate, amount) do
    converted_amount = (rate * amount)/100
    {:ok, converted_amount: converted_amount}
  end

  defp update_session(conn, {:ok, converted_amount: converted_amount}) do
    conn |> put_session(:converted_amount, converted_amount)
  end

  defp update_session(conn, {:error, message: _}) do
    conn |> put_session(:error, true)
  end
end
