defmodule Core.ProcessB do
  use GenServer

  # Server

  @impl true
  def init(state) do
    Process.flag(:trap_exit, true)

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
  def handle_cast({:link, pid}, state) do
    Process.link(pid)
    IO.inspect(pid)

    {:noreply, state}
  end

  @impl true
  def handle_info({:EXIT, from, reason}, state) do
    IO.puts("Teste Process B")
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

  def start_link(_) do
    GenServer.start_link(__MODULE__, [0], name: ProcessB)
  end

  def get() do
    GenServer.call(ProcessB, :get)
  end

  def add() do
    GenServer.cast(ProcessB, {:add, [4, 5, 6]})
  end

  def stop() do
    GenServer.stop(ProcessB)
  end

  def shutdow() do
    GenServer.stop(ProcessB, :shutdow)
  end

  def shutdow(reason) do
    GenServer.stop(ProcessB, {:shutdow, reason})
  end

  def link(pid) do
    GenServer.cast(ProcessB, {:link, pid})
  end
end
