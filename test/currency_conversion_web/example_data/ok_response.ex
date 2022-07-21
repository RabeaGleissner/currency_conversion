{:ok,
  %HTTPoison.Response{
    body: "{\"motd\":{\"msg\":\"If you or your company use this project or like what we doing, please consider backing us so we can co ntinue maintaining and evolving this project.\",\"url\":\"https://exchangerate.host/#/donate\"},\"success\":true,\"query\":{\"from\":\"USD\",\"to\":\"EUR\",\"amount\":100},\"info\":{\"rate\":0.98238},\"historical\":true,\"date\":\"2022-07-20\",\"result\":98.237989}",
    headers: [
      {"Date", "Thu, 21 Jul 2022 05:42:02 GMT"},
      {"Content-Type", "application/json; charset=utf-8"},
      {"Content-Length","352"},
      {"Connection", "keep-alive"},
      {"X-DNS-Prefetch-Control", "off"},
      {"X-Frame-Options", "SAMEORIGIN"},
      {"Strict-Transport-Security", "max-age=15552000; includeSubDomains"},
      # lots more headers omitted
    ],
    request: %HTTPoison.Request{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://api.exchangerate.host/convert?from=usd&to=eur&date=2022-07-20&amount=100"
    },
    request_url: "https://api.exchangerate.host/convert?from=usd&to=eur&date=2022-07-20&amount=100",
    status_code: 200
  }}
