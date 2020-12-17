defmodule NervesjpBasis.Sensor.Webbtn do
  @moduledoc """
  Documentation for `Button`.
  WebAPI送信とボタン・LEDの連携
  ## Examples
  """

  # 関連するライブラリを読み込み
  use GenServer
  require Logger

  alias Circuits.GPIO
  alias NervesjpBasis.Sensor.Web

  # 定数
  # ボタン接続のBCM番号
  @button 5
  # LED接続のBCM番号
  @led 16

  @doc """
  GenServer起動
  """
  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  初期化の処理
  """
  def init(_) do
    # GPIO入力の初期化（ボタン用）
    {:ok, button} = GPIO.open(@button, :input, pull_mode: :pullup)
    # ボタン入力の割込を許可（ボタンを押すとhandle_info関数を呼び出し）
    GPIO.set_interrupts(button, :rising)

    # GPIO出力の初期化（LED用）
    {:ok, led} = GPIO.open(@led, :output)

    {:ok, %{button: button, led: led}}
  end

  @doc """
  ボタン入力の割込の処理
  """
  def handle_info({:circuits_gpio, @button, _timestamp, value}, state) do
    # LEDを点灯
    GPIO.write(state.led, 1)
    # データを送信
    Web.senddata()
    # 待機（単位ms）
    Process.sleep(200)
    # LEDを消灯
    GPIO.write(state.led, 0)

    {:noreply, state}
  end
end
