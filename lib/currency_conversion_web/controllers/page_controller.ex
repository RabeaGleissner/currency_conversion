defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller
  alias CurrencyConversion.Converter

  def index(conn, _params) do
    amount_from_session = get_session(conn, :converted_amount)
    converted_amount = if amount_from_session, do: amount_from_session, else: ""
    conn
    |> put_session(:converted_amount, nil)
    |> render("index.html", converted_amount: converted_amount)
  end

  def convert(conn, %{"amount" => amount, "from" => from, "to" => to, "date" => date}) do
    converted_amount = 3000
    {:ok, converted_amount: converted_amount } = Converter.get_historical_rate(from, to, date, amount)

    conn
    |> put_session(:converted_amount, converted_amount)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
