defmodule Sensor.Aht20 do
  @moduledoc """
  Documentation for `Aht20`.
  温湿度センサAHT20の制御モジュール
  """

  # 関連するライブラリを読み込み
  require Logger
  use Bitwise
  alias Circuits.I2C

  # 定数
  ## i2c-1 for Raspberry Pi, i2c-2 for BBB/BBG Board
  @i2c_bus "i2c-1"
  ## AHT32 I2C Addr
  @i2c_addr 0x38

  # 定数
  ## I2C通信待機時間(ms)
  ## (50msくらいまでOK。40ms以下になると測定に失敗する)
  @i2c_delay 100
  ## 換算定数の事前計算
  @two_pow_20 :math.pow(2, 20)

  @doc """
  温度を表示
  ## Examples
    iex> Aht20.temp
    > temp (degree Celsius)
    22.1
    :ok
  """
  def temp() do
    # AHT20から読み出し
    # 返り値のタプルから温度の部分を取り出して表示
    read_from_aht20()
    |> elem(1)
    |> elem(0)
    |> (fn str -> IO.puts(" > temp: #{str} (degree Celsius)") end).()
  end

  @doc """
  湿度を表示
  ## Examples
    iex> Aht20.humi
    > humi (%)
    41.2
    :ok
  """
  def humi() do
    # AHT20から読み出し
    # 返り値のタプルから湿度の部分を取り出して表示
    read_from_aht20()
    |> elem(1)
    |> elem(1)
    |> (fn str -> IO.puts(" > humi: #{str} (%))") end).()
  end

  @doc """
  AHT20から温度・湿度を取得
  ## Examples
    iex> Aht20.read_from_ath20
    {:ok, {22.4, 40.3}}
    {:error, "Sensor is not connected"}
  """
  def read_from_aht20() do
    # I2Cを開く
    {:ok, ref} = I2C.open(@i2c_bus)

    # AHT20を初期化する
    I2C.write(ref, @i2c_addr, <<0xBE, 0x08, 0x00>>)
    # 処理完了まで一定時間待機
    Process.sleep(@i2c_delay)

    # 温度・湿度を読み出しコマンドを送る
    I2C.write(ref, @i2c_addr, <<0xAC, 0x33, 0x00>>)
    # 処理完了まで一定時間待機
    Process.sleep(@i2c_delay)

    # 温度・湿度を読み出す
    ret =
      case I2C.read(ref, @i2c_addr, 7) do
        # 正常に値が取得できたときは温度・湿度の値をタプルで返す
        {:ok, val} -> {:ok, val |> convert()}
        # センサからの応答がないときはメッセージを返す
        {:error, :i2c_nak} -> {:error, "Sensor is not connected"}
        # その他のエラーのときもメッセージを返す
        _ -> {:error, "An error occurred"}
      end

    # I2Cを閉じる
    I2C.close(ref)

    # 結果を返す
    ret
  end

  @doc """
  生データを温度と湿度の値に変換
    ## Parameters
    - val: POSTする内容
  """
  def convert(src) do
    # バイナリデータ部をバイト分割
    # <<0:state, 1:humi1, 2:humi2, 3:humi3/temp1, 4:temp2, 5:temp3, 6:crc>>
    <<_, h1, h2, ht3, t4, t5, _>> = src

    # 湿度に換算する計算（データシートの換算方法に準じた）
    raw_humi = h1 <<< 12 ||| h2 <<< 4 ||| ht3 >>> 4
    humi = Float.round(raw_humi / @two_pow_20 * 100.0, 1)

    # 温度に換算する計算（データシートの換算方法に準じた）
    raw_temp = (ht3 &&& 0x0F) <<< 16 ||| t4 <<< 8 ||| t5
    temp = Float.round(raw_temp / @two_pow_20 * 200.0 - 50.0, 1)

    # 温度と湿度をタプルにして返す
    {temp, humi}
  end
end
