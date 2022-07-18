defmodule CurrencyConversionWeb.PageControllerTest do
  use CurrencyConversionWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Currency conversion"
  end

  test "GET /convert redirects to root page", %{conn: conn} do
    conn = get(conn, Routes.page_path(conn, :convert), %{amount: "100", from: "USD", to: "GBP", date: "2022-06-16"})
    assert html_response(conn, 302) =~ "redirect"
    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end

  test "GET /convert displays converted amount after redirect", %{conn: conn} do
    conn = get(conn, Routes.page_path(conn, :convert), %{amount: "100", from: "USD", to: "GBP", date: "2022-06-16"})

    assert "/" = redir_path = redirected_to(conn, 302)
    conn = get(recycle(conn), redir_path)

    assert html_response(conn, 200) =~ "3000"
  end
end
