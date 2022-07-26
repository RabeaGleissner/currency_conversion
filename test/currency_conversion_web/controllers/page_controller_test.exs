defmodule CurrencyConversionWeb.PageControllerTest do
  use CurrencyConversionWeb.ConnCase
  use ExUnit.Case, async: true
  import Mox

  alias CurrencyConversion.ApiCache

  setup :verify_on_exit!
  setup do
    on_exit(fn ->
      ApiCache.delete_entry("USDGBP")
    end)
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Currency conversion"
  end

  test "GET /convert redirects to root page", %{conn: conn} do
    expect(HTTPoison.BaseMock, :get, fn _ -> {:ok, %HTTPoison.Response {
      body: "{\"success\":true,\"result\":102,\"info\":{\"rate\": 0.5}}",
      status_code: 200}
    } end)

    conn = get(conn, Routes.page_path(conn, :convert), %{amount: "100", from: "USD", to: "GBP", date: "2022-06-16"})

    assert html_response(conn, 302) =~ "redirect"
    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end

  test "GET /convert displays converted amount after redirect", %{conn: conn} do
    expect(HTTPoison.BaseMock, :get, fn _ -> {:ok, %HTTPoison.Response {
      body: "{\"success\":true,\"result\":102,\"info\":{\"rate\": 0.5}}",
      status_code: 200}
    } end)

    conn = get(conn, Routes.page_path(conn, :convert), %{amount: "100", from: "USD", to: "GBP", date: "2022-06-16"})
    assert "/" = redir_path = redirected_to(conn, 302)

    conn = get(recycle(conn), redir_path)
    assert html_response(conn, 200) =~ "102"
  end

  test "GET /convert displays error message when API returns error", %{conn: conn} do
    expect(HTTPoison.BaseMock, :get, fn _ -> {:error, %HTTPoison.Error{
      id: nil,
      reason: :nxdomain
      }
    } end)

    conn = get(conn, Routes.page_path(conn, :convert), %{amount: "100", from: "USD", to: "GBP", date: "2022-06-16"})
    assert "/" = redir_path = redirected_to(conn, 302)

    conn = get(recycle(conn), redir_path)
    assert html_response(conn, 200) =~ "Apologies, there was an error"
  end
end
