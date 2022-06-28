defmodule TestOtp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: TestOtp.Worker.start_link(arg)
      # {TestOtp.Worker, arg}
      Supervisor.child_spec({Core.ProcessA, :process1}, id: :process1),
      Supervisor.child_spec({Core.ProcessA, :process2}, id: :process2),
      Supervisor.child_spec({Core.ProcessA, :process3}, id: :process3),
      Supervisor.child_spec({Core.ProcessA, :process4}, id: :process4),
      Supervisor.child_spec({Core.ProcessA, :process5}, id: :process5),
      Core.ProcessB,
      Core.ProcessC
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestOtp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
