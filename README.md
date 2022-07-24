# Currency converter from the past

Easily convert amounts of money using the rates from past dates.

Currency API used: https://exchangerate.host/

## Technical

- Using session to keep track of data
- Caching API response with ETS
- Mocking with Mox

Next:
- styling with Tailwind


### ETS table schema

- Key: currency from + currency to
- Value: date, rate

Insert:
:ets.insert_new(:api_cache, {"USDEUR", "2012/10/22", 0.45})

Retrieve:
:ets.match_object(:api_cache, {:"USDEUR", :"2012/10/22", :"$3"})

Example return data:
[{"USDEUR", "2012/10/22", 0.45}]


## How to run it

* Install dependencies with `mix deps.get`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now visit [`localhost:4000`](http://localhost:4000)
