defmodule NervesjpBasis.Sensor.Web do
  @moduledoc """
  Documentation for `Web`.
  WebAPIとのやりとりモジュール
  """

  alias NervesjpBasis.Sensor.Aht20

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
  end

  # 指定のURLにPOSTする
  ## Parameters
  ## - val: POSTする内容
  ## - url: POSTするAPIのURL
  defp post(val, url) do
    HTTPoison.post!(url, body(val), header())
  end

  # JSONデータの生成
  ## Parameters
  ## - val: POSTする内容
  defp body(val) do
    # 現在時刻を取得
    time =
      Timex.now()
      |> Timex.to_unix()

    # JSONに変換
    Jason.encode!(%{value: %{name: @my_name, value: val, time: time}})
  end

  # ヘッダの生成
  defp header() do
    [{"Content-type", "application/json"}]
  end
end
