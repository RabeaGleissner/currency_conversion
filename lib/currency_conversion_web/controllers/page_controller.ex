defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller
  alias CurrencyConversion.Converter

  def index(conn, _params) do
    amount_from_session = get_session(conn, :converted_amount)
    converted_amount = if amount_from_session, do: amount_from_session, else: ""
    is_error = get_session(conn, :error)

    conn
    |> put_session(:converted_amount, nil)
    |> put_session(:error, nil)
    |> render("index.html", %{converted_amount: converted_amount, error: is_error})
  end

  def convert(conn, %{"amount" => amount, "from" => from, "to" => to, "date" => date}) do
    conversion_result = Converter.get_historical_rate(from, to, date, amount)

    conn
    |> update_session(conversion_result)
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
end
