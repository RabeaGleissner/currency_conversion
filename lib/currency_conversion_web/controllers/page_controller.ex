defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def convert(conn, %{"amount" => amount, "from" => from, "to" => to, "date" => date}) do
    IO.inspect(from)
    IO.inspect(to)
    IO.inspect(date)
    IO.inspect(amount)
    converted_amount = 3000
    render(conn, "index.html", converted_amount: converted_amount)
  end
end
