## 作品タイトル

dartsduino

![screenshot](https://dl.dropboxusercontent.com/u/972960/Documents/dartsduino/dartsduino2.gif)


## 作品の概要

改造して Arduino を搭載した市販のダーツボードと、USB ケーブルで接続した PC を用いて、様々な種類のダーツゲームを楽しむことができます。
また、開発者にとっては、新たなダーツゲームを Web Components として実装し、容易に組み込むことができるように設計しています。

この作品では、IoT が広く用いられ、Web と実世界が結びつく次代を見据え、Web と実世界それぞれの長所を兼ね備えた新しい可能性を模索することを目指しました。
新しい可能性を模索する切り口のひとつとして、今回はダーツを題材としています。


## 技術的なアピールポイント

本作品は、以下の図のように、複数の要素によって構成されています。

![構成図](https://dl.dropboxusercontent.com/u/972960/Documents/dartsduino/dartsduino2.png)

* [dartsduino-sketch](https://github.com/dartsduino2/dartsduino-sketch)
  * 市販のダーツボードに元々実装されているマイコンを [Arduino Nano](http://arduino.cc/en/Main/arduinoBoardNano) に置き換え、
    ダーツがボードに当たった際に所望のデータを PC へ送信できるよう改造しました。
    * ダーツボードは、1500円程度の安い製品から 2万円弱の比較的高価な製品まで、3種類の製品を使って試しました。
      ダーツがダーツボードに当たったことを検知する原理や、電子回路の全体構成など、基本的な作りは 3種類とも共通していました。
  * Arduino 上で動かすコード (sketch) は、ダーツの各セルに配置されているセンサを走査し、ダーツがボードに当たったことを検出します。
    * ダーツが当たったことを検知し損ねないためには、センサを高速に走査することが必要です。
    * コードを実装した当初、ダーツがボードに当たったことを確実に検出できませんでした (検出率 10％程度)。
      このとき、すべてのセンサの走査 1回に要する時間は 1.8ms でした。
      その後、アセンブリ言語レベルでコードを最適化し、走査に要する時間を 0.18ms まで短くすることで、確実に検出できるようになりました。
  * 参考サイト
    * [Arduino Nano](http://arduino.cc/en/Main/arduinoBoardNano)
    * [Arduinoで遊ぶページ](http://garretlab.web.fc2.com/arduino/inside/index.html)
* [dartsduino-device](https://github.com/dartsduino2/dartsduino-device)
  * dartsduino-sketch から送信されたデータは、PC ではシリアルからのデータとして受信できます。
    このデータを受信するアプリは Chrome Apps として実装しました。
    * Chrome Apps の雛形生成には Yeoman の [generator-chromeapp](https://github.com/yeoman/generator-chromeapp) を用いました。
    * この Chrome Apps は単体では機能しないため、Chromeウェブストア上で公開していません。
  * dartsduino-device は、[PeerJS](http://peerjs.com/) を用いて、
    ローカルマシンに立ち上げた [PeerJS server](https://github.com/peers/peerjs-server)
    へ接続し、他プロセスからの接続を待ちます。
  * 他プロセスから接続された後は、dartsduino-sketch より受信したデータを、
    PeerJS を用いた WebRTC により他プロセスへ送信します。
  * 今回はローカルマシンの PeerJS server へ接続していますが、
    将来的には、NTTコミュニケーションズさんの [SkyWay](http://nttcom.github.io/skyway/) など外部のサービスを利用することで、
    他のマシンへデータをリアルタイムに送信することができ、たとえば遠隔地の人と対戦することも実現可能になります。
  * 参考サイト
    * [HTML5 Chrome Packaged Apps and Arduino: bidirectional communication via serial](http://www.fabiobiondi.com/blog/2014/02/html5-chrome-packaged-apps-and-arduino-bidirectional-communication-via-serial/)
    * [chrome.serial](https://developer.chrome.com/apps/serial)
    * [PeerJS Documentation](http://peerjs.com/docs/)
* [dartsduino](https://github.com/dartsduino2/dartsduino)
  * ダーツゲームのコア部分です。以下の darts-ui と game-group を包含しています。
* [darts-ui](https://github.com/dartsduino2/darts-ui)
  * ダーツボードを表現する UI 部品です。
    [Polymer](http://www.polymer-project.org/) を利用して、再利用可能なモジュール (Web Components) として実装しました。
    * [AngularJS](https://angularjs.org/) の [directive](https://docs.angularjs.org/guide/directive) を利用して UI 部品を実装すると、
      AngularJS に依存し、[Backbone.js](http://backbonejs.org/) など他の MV\* framework を利用した web app にて再利用することが難しくなります。
      Web Components として実装することで、MV\* framework の種類によらず再利用可能となります。
  * ダーツボードの表示は [Snap.svg](http://snapsvg.io/) を用いて SVG によって描画しています。
    * canvas ではなく SVG を用いたことで、スケーラブルな描画を実現できただけでなく、
      クリックした際のイベントハンドラを容易に実装でき、ハイライトなどの表現を CSS を用いてシンプルに実装することができました。
  * darts-ui の初期化後、ローカルマシンの PeerJS server へ接続し、待機中の dartsduino-device と P2P 接続します。
    ダーツがダーツボードに当たったこととその位置は、dartsduino-device より送られるデータによって検知します。
  * また、主にデバッグ用途として、ブラウザ上に表示されたダーツボードをクリックすることで、ダーツが当たったことをシミュレートできます。
  * 参考サイト
    * [なぜ Web Components はウェブ開発に革命を起こすのか](http://blog.agektmr.com/2014/05/web-components.html)
    * [Polymer](http://www.polymer-project.org/)
    * [Snap.svg](http://snapsvg.io/)
* game-group と各種ゲーム (game-time-attack など)
  * game-group は、各ゲームのモジュールを子要素として持ち、管理します。
  * 各ゲームは Polymer を用いて Web Components としてモジュール化し、ゲームそれぞれ固有のルールやスコア計算のアルゴリズム、スコアを表示する UI 部品などをカプセル化しました。
    * Web Components は、ボタンなどの UI 部品を実装するといった文脈で語られることが多いですが、
      UI 部品の集合体である View や、表示する要素を一切持たない機能のみのモジュールなど、
      様々なケースにおいて適用可能です。
      こういった Web Components の特長に強い感銘を受け、本作品では各種ゲームの実装に Polymer を用いるなど、Web Components を多用しています。
    * ゲームのステータス管理や表示/非表示の切り替えといったゲーム共通の機能は、game-base と呼ぶ Web Component に実装し、
      各ゲームはこの game-base を継承することで効率的に実装できる設計としました。
      この設計には、Web Components が他の Web Components を継承できる Polymer の機能が非常に役立っています。
  * 参考サイト
    * Polymer
      * [Extending other elements](http://www.polymer-project.org/docs/polymer/polymer.html#extending-other-elements)


## 企画上のアピールポイント

元々の発端は、Mozilla さんが [Mecha-Mozilla](http://mecha-mozilla.org/) にて掲げている「ウェブと実世界のいい感じの関係性」に強い刺激を受けたことに始まりました。

その後、気づいたことのひとつが「Web の高い拡張性や進化のスピードについてきていない実世界」でした。
たとえば市販のダーツボードは、プリセットされたゲームがマイコン内に実装されていて、ユーザが購入後にゲームを独自に改造、または新規のゲームを追加することができません。

そこで、実世界でなされていることの一部を Web へシフトすることで自由度を高め、かつては固定的だったゲームをユーザが自由に改変・追加できることを目指しました。
またソーシャルコーディングなどにより、これまでになかったまったく新しいダーツゲームを共創し評価できる場や文化を作り、Web の進化をダーツの世界へ持ち込めるか模索したい、と考えました。


## 今後の予定

* 他の人も市販のダーツボードを改造できるよう、改造方法を GitHub か [gitFAB](http://gitfab.org/) にて公開
  * ちなみに回路は、Arduino Nano にプルダウン抵抗をつなげただけの非常に簡素な回路です。
    ![dartsduino-hw](https://dl.dropboxusercontent.com/u/972960/Documents/dartsduino/dartsduino-hw.png)
* game-base や各ゲームのリファクタリング
  * Web Components の素晴らしさに気づいたタイミングが応募締め切りの 10日ほど前で、まずは本作品が動作することを優先したため、
    見直したい設計や気持ち悪い実装が残ってしまいました。リファクタリング、もしくはフルスクラッチで実装し直したいところです。
  * index.html にて読み込んだ Bootstrap の CSS は、各ゲームの Shadow DOM に反映されない (works as designed) ため、
    ゲームそれぞれでも Bootstrap の CSS を読み込んでいます。
    Web Components の portability を高めるためにはこの仕様は正しいようにも思いますが、
    たとえば theme change を実現する (1箇所の変更が全体に波及する) ケースなどにおいて、どのように設計・実装すれば良いのか、
    まだ見通しがついていません。これを明らかにするため、試行錯誤してみる予定です。
* 見栄え良くデザインしてくれる人を探す
