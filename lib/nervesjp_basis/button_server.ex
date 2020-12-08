defmodule NervesjpBasis.ButtonServer do
  use GenServer

  require Logger

  alias Circuits.GPIO

  @button 5
  @led 16

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def init(_) do
    {:ok, button} = GPIO.open(@button, :input, pull_mode: :pullup)
    GPIO.set_interrupts(button, :both)

    {:ok, led} = GPIO.open(@led, :output)

    {:ok, %{button: button, led: led}}
  end

  def handle_info({:circuits_gpio, @button, _timestamp, value}, state) do
    Logger.debug("Button is now #{value}")

    GPIO.write(state.led, value)

    {:noreply, state}
  end
end
