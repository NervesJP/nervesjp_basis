defmodule NervesjpBasis.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    if should_start_wizard?() do
      VintageNetWizard.run_wizard()
      wizard_running_led()
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NervesjpBasis.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: NervesjpBasis.Worker.start_link(arg)
        # {NervesjpBasis.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: NervesjpBasis.Worker.start_link(arg)
      # {NervesjpBasis.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: NervesjpBasis.Worker.start_link(arg)
      # {NervesjpBasis.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:nervesjp_basis, :target)
  end

  defp should_start_wizard?() do
    pin_number = Application.get_env(:nervesjp_basis, :wizard_start_gpio_pin, 5)

    with {:ok, gpio} <- Circuits.GPIO.open(pin_number, :input) do
      if Circuits.GPIO.read(gpio) == 1, do: true, else: false
    else
      _ -> false
    end
  end

  defp wizard_running_led() do
    pin_number = Application.get_env(:nervesjp_basis, :wizard_running_gpio_pin, 16)

    with {:ok, gpio} <- Circuits.GPIO.open(pin_number, :output) do
      Circuits.GPIO.write(gpio, 1)
    end
  end
end
