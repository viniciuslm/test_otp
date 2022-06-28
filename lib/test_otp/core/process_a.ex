defmodule Core.ProcessA do
  use GenServer

  # Server

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:add, items}, state) do
    {:noreply, state ++ items}
  end

  @impl true
  def handle_info({:EXIT, from, reason}, state) do
    IO.inspect(from)
    IO.inspect(reason)
    {:noreply, state}
  end

  @impl true
  def terminate(:normal, state) do
    IO.puts("stop")
    state
  end

  @impl true
  def terminate(:shutdow, state) do
    IO.puts("shutdown")
    state
  end

  @impl true
  def terminate({:shutdow, motivo}, state) do
    IO.puts("shutdown")
    IO.inspect(motivo)
    state
  end

  # Client

  def start_link(name) do
    GenServer.start_link(__MODULE__, [0], name: name)
  end

  def get(name) do
    GenServer.call(name, :get)
  end

  def add(name) do
    GenServer.cast(name, {:add, [1, 2, 3]})
  end

  def stop(name) do
    GenServer.stop(name)
  end

  def shutdow(name) do
    GenServer.stop(name, :shutdow)
  end

  def shutdow(name, reason) do
    GenServer.stop(name, {:shutdow, reason})
  end

  def link2() do
    Process.link(:process2)
  end
end
