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
  ## Web API
  @url_value "https://nervesjp-wwest2021.japaneast.cloudapp.azure.com/values"

  @doc """
  測定データを打ち上げ
  ## Examples
    iex> Web.senddata
    > send: 22.7 degree Celsius, 39.9 %
    :ok
  """
  def senddata() do
    # センサから温度を読み出し
    {:ok, {temp, humi}} = Aht20.read_from_aht20()
    # 現在値の表示
    IO.puts(
      " > send: [name : #{@my_name}] / temp: #{inspect(temp)} (degree Celsius), humi: #{
        inspect(humi)
      } (%)"
    )

    # WebAPIにPOSTする
    post(temp, humi, @url_value)
  end

  # 指定のURLにPOSTする
  ## Parameters
  ## - temp, humi: POSTする内容
  ## - url: POSTするAPIのURL
  defp post(temp, humi, url) do
    HTTPoison.post!(url, body(temp, humi), header())
  end

  # JSONデータの生成
  ## Parameters
  ## - temp, humi: POSTする内容
  defp body(temp, humi) do
    # JSONに変換
    Jason.encode!(%{value: %{name: @my_name, temperature: temp, humidity: humi}})
  end

  # ヘッダの生成
  defp header() do
    [{"Content-type", "application/json"}]
  end
end
