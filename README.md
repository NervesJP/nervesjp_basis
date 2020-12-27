# nervesjp_basis
ALGYANハンズオンセミナ＠2020/12/27の配布用Nervesファームウェア

- connpassイベントページ：[【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)

## プレゼント枠の皆さまへ

超豪華なプレゼント！とともに，ファームウェアを書込み済みのmicroSDカードをお届けします．はやる気持ちを抑えて当日までお待ちください．もちろんmicroSDは初期化などしないでください^^;

書込み済みのファームウェアは，今回のハンズオン向けの開発環境 `nerves-algyan-devcontainer` で作業することを前提にしています．下記に従って準備を進めておいてください．

- [ALGYAN x Seeed x NervesJPハンズオン！に向けた開発環境の準備方法](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8)

## 見学枠の皆さまへ

特に，「見学枠」だけど見てるだけ〜とは言ってないよ〜という方向けの案内です．  

### 必要なもの

まずは，下記のアイテムをご用意ください．

- RasPi4 4GBモデル
- [Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
- [Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)
- [Grove Green LED](https://wiki.seeedstudio.com/Grove-Red_LED/)
- [Grove AHT20 I2C (温湿度センサ)](https://wiki.seeedstudio.com/Grove-AHT20-I2C-Industrial-Grade-Temperature%26Humidity-Sensor/)
- AC-DCアダプタ（Type-C, 5V3A）
- microSDカード（16GBくらいあればよい）

Grove Buttonは(P)じゃなくても構いません．また，LEDも緑じゃなくてよいです．AHT20 I2Cはあまり国内流通が無いようで，Seeed BazzarかDigi-Key辺りが良いかと思います．発送まで１週間ほど掛かりますので，早めに手配しましょう．

このリポジトリのNervesファームウェアは，今回のハンズオン向けにRasPi4に特化して用意しています．他のRasPiボードで臨みたい方は，[ NervesJPのSlack ](https://nerves-jp.connpass.com/)か，[ このリポジトリのIssue ](https://github.com/NervesJP/nervesjp_basis/issues)にて事前にご相談ください．

### microSDカードの準備

まずはもちろん，[「ALGYAN x Seeed x NervesJPハンズオン！に向けた開発環境の準備方法」](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8)に従って開発環境を準備してください．特に「fwupのインストール」が大事です．

microSDカードに，ハンズオン向けのファームウェアを書き込む必要があります．  
下記からファームウェアをダウンロードしてください．

- [https://github.com/NervesJP/nervesjp_basis/releases/download/v1.0/nervesjp_basis.fw](https://github.com/NervesJP/nervesjp_basis/releases/download/v1.0/nervesjp_basis.fw)

Windowsの方は，PowerShellまたはコマンドプロンプトを **「管理者として実行する」** で開いてください．MacやLinuxの方は普通にターミナルを開いてください．

あとはこんな感じです．

1. ターミナルでファームウェアをダウンロードしてきたところに移動する
2. microSDカードをPCに接続する
3. 下記のコマンドを実行する

```bash
fwup nervesjp_basis.fw
```

あとは当日をお楽しみにっ！！

## その他の注意事項

このリポジトリのNervesファームウェアは，今回のハンズオン向け（特にRasPi4向け）の固有の対応を幾つか行っています．ハンズオンの終了後には，その辺りを更新する予定です．

