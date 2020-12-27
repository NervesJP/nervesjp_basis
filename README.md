# nervesjp_basis
ALGYANハンズオンセミナ＠2020/12/27のNervesアプリケーション

- connpassイベントページ：[【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)

## ハンズオンのテキスト

- [基本編：まずはNervesをとにかく動かしてみよう！](https://docs.google.com/presentation/d/1u7V6aR0wrWs23oGmNq6Scl6M_WRpa0eyB4lSqyOsbRM/edit?usp=sharing)
- [応用編：これぞ一気通貫のIoT！Nervesアプリをビルドして動かしてみよう](https://docs.google.com/presentation/d/1ybBMKVnYnImRv1V_vozVXTOt-DwfpUiAwqhrNSubt3k/edit?usp=sharing)

- [動画アーカイブ(YouTube)](https://youtu.be/A1AiQZR7UFQ)

[connpassイベントページの資料一覧](https://algyan.connpass.com/event/197306/presentation/)もご参照ください．

## 必要なもの

- RasPi4 4GBモデル
- [Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
- [Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)
- [Grove Green LED](https://wiki.seeedstudio.com/Grove-Red_LED/)
- [Grove AHT20 I2C (温湿度センサ)](https://wiki.seeedstudio.com/Grove-AHT20-I2C-Industrial-Grade-Temperature%26Humidity-Sensor/)
- AC-DCアダプタ（Type-C, 5V3A）
- microSDカード（16GBくらいあればよい）

Grove Buttonは(P)じゃなくても構いません．また，LEDも緑じゃなくてよいです．AHT20 I2Cはあまり国内流通が無いようで，Seeed BazzarかDigi-Key辺りが良いかと思います．また，発送まで１週間ほど掛かります．

このリポジトリのNervesファームウェアは，今回のハンズオン向けにRasPi4に特化して用意しています．他のRasPiボードで臨みたい方は，[ NervesJPのSlack ](https://nerves-jp.connpass.com/)か，[ このリポジトリのIssue ](https://github.com/NervesJP/nervesjp_basis/issues)にてご相談ください．

## microSDカードの準備

まずはElixir/Nervesの開発環境をご用意ください．

ハンズオン本番向けに用意したものは，開発環境の統一と手順の簡単化のために，幾つかのcheatをしています．特にSSH通信用の鍵は共通化しているため，セキュリティ上のリスクがあります．以下のいずれかの環境を構築して使用してください．

- dev-containerを使用する開発環境：[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する - Qiita](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)
- WSL 2のみを使用する開発環境（上記よりビルド性能が良い，ただし難易度がある）：[ElixirでIoT#4.1.1：WSL 2でNerves開発環境を整備する - Qiita](https://qiita.com/takasehideki/items/b8ea8b3455c70398178a)
- macOSやLinux向けのネイティブな開発環境：[ElixirでIoT#4.1：Nerves開発環境の準備 - Qiita](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)


最初からやり直したい！自分のSSH鍵で準備してやるぞっ！という方は，下記を実行してファームウェアを作成してください．

```shell-session
$ git clone https://github.com/NervesJP/nervesjp_basis
$ cd nervesjp_basis
$ git checkout v1.0
$ export MIX_TARGET=rpi4
$ mix deps.get
$ mix firmware
```

`_build/rpi4_dev/nerves/images/nervesjp_basis.fw` というのがハンズオンのスタートラインとなっているNervesファームウェアです．こちらをmicroSDカードに書き込みます．

dev-containerの方は，ホストPC上で，`fwup`を実行します．    
Windowsの方は，PowerShellまたはコマンドプロンプトを **「管理者として実行する」** で開いて，MacやLinuxの方は普通にターミナルを開いて，下記を実行してください．

```shell-session
$ fwup _build/rpi4_dev/nerves/images/nervesjp_basis.fw
```

WSL 2やmacOSでネイティブに環境構築された方は，これだけです．

```shell-session
$ mix burn
```

## [Release](https://github.com/NervesJP/nervesjp_basis/releases)履歴

- v1.0: ALGYANハンズオン向けの参加者に配布したファームウェアのバージョン
- v1.1: 応用編の内容込みのバージョン

