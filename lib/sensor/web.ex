defmodule Sensor.Web do
  @moduledoc """
  Documentation for `Web`.
  WebAPIとのやりとりモジュール
  """

  alias Sensor.Aht20

  # 定数
  ## ここの部分を、あなたのハンドル名に書き換えてください
  @my_name "nervesjp_algyan"

  # 定数
  ## Web APi
  @url_temp "https://phx.japaneast.cloudapp.azure.com/temperatures"
  @url_humi "https://phx.japaneast.cloudapp.azure.com/humidities"

  @doc """
  測定データを打ち上げ
  ## Examples
    iex> Web.senddata
    > send: 22.7 degree Celsius, 39.9 %
    :ok
  """
  def senddata() do
    # センサから温度を読み出し
    {:ok, {temp, _}} = Aht20.read_from_aht20()
    # 現在値の表示
    IO.puts(" > send: [name: #{@my_name}] / temp: #{inspect(temp)} (degree Celsius)")

    # WebAPIにPOSTする
    post(temp, @url_temp)

    # **** 教材（回答例） ****
    # # センサから温度、湿度を読み出し
    # {:ok, {temp, humi}} = Aht20.read_from_aht20()
    # # 現在値の表示
    # IO.puts(
    #   " > send: [name : #{@my_name}] / temp: #{
    #     inspect(temp)} (degree Celsius), humi: #{inspect(humi)
    #   } (%)"
    # )
    # # WebAPIにPOSTする
    # post(temp, @url_temp)
    # post(humi, @url_humi)
  end

  @doc """
  指定のURLにPOSTする
    ## Parameters
    - val: POSTする内容
    - url: POSTするAPIのURL
  """
  def post(val, url) do
    HTTPoison.post!(url, body(val), header())
  end

  @doc """
  JSONデータの生成
    ## Parameters
    - val: POSTする内容
  """
  def body(val) do
    # 現在時刻を取得
    time =
      Timex.now()
      |> Timex.to_unix()

    # JSONに変換
    Jason.encode!(%{value: %{name: @my_name, value: val, time: time}})
  end

  @doc """
  ヘッダの生成
  """
  def header() do
    [{"Content-type", "application/json"}]
  end
end
