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


    #%HTTPoison.Response{status_code: 200,
      #headers: [{"content-type", "application/json"}],
      #body: "{...}"}

    #%HTTPoison.Response{
  #body: "{\"motd\":{\"msg\":\"If you or your company use this project or like what we doing, please consider backing us so we can
#tinue maintaining and evolving this project.\",\"url\":\"https://exchangerate.host/#/donate\"},\"success\":true,\"query\":{\"from\
#"GBP\",\"to\":\"EUR\",\"amount\":233},\"info\":{\"rate\":1.160271},\"historical\":true,\"date\":\"2022-07-01\",\"result\":270.3430
#",
