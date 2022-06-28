defmodule Core.ProcessC do
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

  # Client

  def start_link(_) do
    GenServer.start_link(__MODULE__, [0], name: ProcessC)
  end

  def get() do
    GenServer.call(ProcessC, :get)
  end

  def add() do
    GenServer.cast(ProcessC, {:add, [7, 8, 9]})
  end

  def stop() do
    GenServer.stop(ProcessC)
  end

  def shutdow() do
    GenServer.stop(ProcessC, :shutdow)
  end

  def shutdow(reason) do
    GenServer.stop(ProcessC, {:shutdow, reason})
  end

  def get_pid() do
    Process.whereis(ProcessC)
  end
end
