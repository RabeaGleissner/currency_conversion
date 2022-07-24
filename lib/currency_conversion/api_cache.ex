defmodule CurrencyConversion.ApiCache do
  use GenServer

  @name __MODULE__

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

  def init(_) do
    IO.puts("Creating ETS #{@name}")
    :ets.new(:currency_api_cache, [:set, :named_table])
    {:ok, "ETS created"}
  end

  def insert(key, date, rate) do
    GenServer.call(@name, {:insert, {key, date, rate}})
  end

  def handle_call({:insert, data}, _ref, state) do
    :ets.insert_new(:currency_api_cache, data)
    {:reply, :ok, state}
  end
end
