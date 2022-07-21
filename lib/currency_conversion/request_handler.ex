defmodule CurrencyConversion.RequestHandler do
  def get(url) do
    url
    |> http_client().get()
    |> case do
      {:ok, %HTTPoison.Response{body: raw_body, status_code: code}} -> {code, raw_body}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
    |> (fn {ok, body} ->
      body
      |> Poison.decode(keys: :atoms)
      |> case do
        {:ok, parsed} -> {ok, parsed}
        _ -> {:error, body}
      end
    end).()
  end

  defp http_client do
    Application.get_env(:currency_conversion, :http_client)
  end
end
