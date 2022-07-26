defmodule CurrencyConversion.RequestHandler do
  def get(url) do
    url
    |> http_client().get()
    |> case do
      {:ok, %HTTPoison.Response{body: raw_body, status_code: code}} -> {code, decode(raw_body)}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  defp decode(json) do
    json
    |> Poison.decode(keys: :atoms)
    |> IO.inspect
    |> case do
      {:ok, parsed} -> {:ok, parsed}
      _ -> {:error, "JSON decode failed"}
    end
  end

  defp http_client do
    Application.get_env(:currency_conversion, :http_client)
  end
end
