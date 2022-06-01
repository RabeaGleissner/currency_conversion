defmodule CurrencyConversionWeb.PageController do
  use CurrencyConversionWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
