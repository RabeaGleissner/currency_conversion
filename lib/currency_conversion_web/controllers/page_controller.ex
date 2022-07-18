defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller

  def index(conn, _params) do
    amount_from_session = get_session(conn, :converted_amount)
    converted_amount = if amount_from_session, do: amount_from_session, else: ""
    conn
    |> put_session(:converted_amount, nil)
    |> render("index.html", converted_amount: converted_amount)
  end

  def convert(conn, %{"amount" => amount, "from" => from, "to" => to, "date" => date}) do
    IO.inspect(from)
    IO.inspect(to)
    IO.inspect(date)
    IO.inspect(amount)
    converted_amount = 3000
    conn
    |> put_session(:converted_amount, converted_amount)
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
