## 作品タイトル

dartsduino


## 作品の概要

改造した市販のダーツボードを PC と接続し、様々な種類のダーツゲームを楽しむことができます。
また、開発者にとっては、新たなダーツゲームを Web Components として実装し、容易に組み込むことができるように設計しています。

この作品では、IoT が広く用いられ、Web と実世界が結びつく将来を見据え、Web と実世界それぞれの長所を兼ね備えた新しい可能性を模索することを目指しました。
新しい可能性を模索する切り口のひとつとして、今回はダーツを題材としています。


## 技術的なアピールポイント

![構成図](https://dl.dropboxusercontent.com/u/972960/Documents/dartsduino/dartsduino2.png)

* [dartsduino-sketch](https://github.com/dartsduino2/dartsduino-sketch)
  * 市販のダーツボードに元々実装されているマイコンを Arduino に置き換え、ダーツがボードに当たった際に所望のデータを PC へ送信できるよう改造しました。
  * Arduino 上で動かすコード (sketch) は、ダーツの各セルに配置されているセンサを走査し、ダーツがボードに当たったことを検出します。
    コードを実装した当初は走査のサイクルが 1.8ms 間隔で、ダーツがボードに当たったことを正しく検出できる確率は 10％程度でした。
    そこで、アセンブリ言語レベルでコードをチューニングし、走査間隔を 0.18ms まで短くすることで、正しく検出できる確率を 100％にすることができました。
* [dartsduino-device](https://github.com/dartsduino2/dartsduino-device)
  * ダーツボードから送信されたデータは、PC ではシリアルからのデータとして受信できます。このデータを受信するアプリは Chrome app として実装しました。
  * dartsduino-device が受信したデータは、PeerJS を用いた WebRTC により、PeerJS server へ送られます。
    今回はローカルマシンの PeerJS server へデータを送っていますが、NTTコミュニケーションズさんの SkyWay などを利用することで、
    他のマシンへデータをリアルタイムに送信することができ、たとえば遠隔地の人と対戦することも実現可能になります。
* [dartsduino](https://github.com/dartsduino2/dartsduino)
  * ダーツゲームのコア部分です。以下の darts-ui と game-group を包含しています。
* [darts-ui](https://github.com/dartsduino2/darts-ui)
  * ダーツボードを表現する UI 部品です。Polymer を利用して、再利用可能なモジュール (Web Components) として実装しました。
  * ダーツがダーツボードに当たったことと、当たった位置は、PeerJS server から送らるデータによって検出することができます。
    また、主にデバッグ用途として、ブラウザ上に表示されるダーツボードをクリックすることで、ダーツが当たったことをシミュレートすることができます。
* game-group と各種ゲーム (game-time-attack など)
  * 各種ダーツゲームは Polymer を利用してモジュール化し、各ゲーム固有のルールやスコア計算のアルゴリズム、スコア表示 UI 部品などをカプセル化しました。
  * ゲームのステータス管理や表示/非表示の切り替えといったゲーム共通の機能は、game-base と呼ぶ Web Component に実装し、各ゲームはこの game-base を継承する設計としました。


## 企画上のアピールポイント

元々の発端は、Mozilla さんが [Mecha-Mozilla](http://mecha-mozilla.org/) にて掲げている「ウェブと実世界のいい感じの関係性」に強い刺激を受けたことに始まりました。

その後、気づいたことのひとつが「Web の進化のスピードについてきていない実世界」でした。
たとえば市販のダーツボードは、プリセットされたゲームがマイコン内に実装されていて、ユーザが購入後にゲームを独自に改造、または新規のゲームを追加することができません。

そこで、実世界でなされていることの一部を Web へシフトすることで自由度を高め、かつては固定的だったゲームをユーザが自由に改変・追加できることを目指しました。
またソーシャルコーディングなどにより、これまでになかったまったく新しいダーツゲームを共創し評価できる場や文化を作り、Web の進化をダーツの世界へ持ち込めるか模索したい、と考えました。