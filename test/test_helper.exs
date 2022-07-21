ExUnit.start()

Mox.defmock(HTTPoison.BaseMock, for: HTTPoison.Base)

Application.put_env(:currency_conversion, :http_client, HTTPoison.BaseMock)
