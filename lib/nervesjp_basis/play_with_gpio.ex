defmodule NervesjpBasis.PlayWithGpio do
  def write(pin_number, on_or_off) do
    {:ok, gpio} = Circuits.GPIO.open(pin_number, :output)
    Circuits.GPIO.write(gpio, on_or_off)
  end

  def read(pin) do
    {:ok, gpio} = Circuits.GPIO.open(pin, :input)
    Circuits.GPIO.read(gpio)
  end

  #
  # HOMEWORK: LEDを点滅させる関数を作る
  #
  def blink() do
    # ElixirではProcess.sleep() を使うことは推奨されないが
    # ここでは簡単のために使ってよいこととする, 引数の単位はmsec
    Process.sleep(1000)
  end
end
