defmodule CurrencyConversion.ApiCache do
  use GenServer

  @name __MODULE__

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

  def init(state) do
    IO.puts("Creating ETS #{@name}")
    :ets.new(:currency_api_cache, [:set, :named_table])
    {:ok, state}
  end

  def insert(key, date, rate) do
    GenServer.call(@name, {:insert, {key, date, rate}})
  end

  def retrieve(key, date) do
    GenServer.call(@name, {:retrieve, {key, date}})
  end

  def handle_call({:insert, data}, _ref, state) do
    :ets.insert_new(:currency_api_cache, data)
    {:reply, :ok, state}
  end

  def handle_call({:retrieve, {key, date}}, _ref, state) do
    cached_data = :ets.match_object(:currency_api_cache, {key, date, :"$3"})
    case Enum.empty?(cached_data) do
      true -> {:reply, state, []}
      false ->
        [{_, _, rate}] = cached_data
        {:reply, rate, []}
    end
  end
end
