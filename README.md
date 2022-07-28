# Currency converter from the past

A toy project to learn Phoenix.

https://historical-currency-conversion.herokuapp.com/

## Technical

- Using session to keep track of data
- Caching currency API response with ETS
- Mocking with Mox
- styling with Tailwind
- deployed to Heroku

Next:
- handle invalid input errors
  - future date
  - text instead of numbers


### ETS table schema

- Key: currency from + currency to
- Value: date, rate

```
# Insert:
:ets.insert_new(:api_cache, {"USDEUR", "2012/10/22", 0.45})

# Retrieve:
:ets.match_object(:api_cache, {:"USDEUR", :"2012/10/22", :"$3"})

# Example return data:
[{"USDEUR", "2012/10/22", 0.45}]
```


## How to run it

* Install dependencies with `mix deps.get`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now visit [`localhost:4000`](http://localhost:4000)
