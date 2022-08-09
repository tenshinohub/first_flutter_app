import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webviewx/webviewx.dart';

void main() => runApp(SlidingUpPanelExample());

class SlidingUpPanelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlidingUpPanel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: '東海オンエア聖地\nby 東海ドライバー'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 80.0;

  PanelController _pc = new PanelController();

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    //_panelHeightOpen = MediaQuery.of(context).size.height * .80;
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.9;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'MPLUS1p',
              fontSize: 20, fontWeight: FontWeight.w500
            )
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {_pc.close();},
            child: Icon(
              Icons.arrow_downward, //←任意のIconへ変更可能
              size: 20,
              color: Colors.orange,
            )
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: _pc,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
          /*
          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {},
              backgroundColor: Colors.white,
            ),
          ),
          */
          /*
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )
                  )
              )
          ),
          */

          //the SlidingUpPanel Title
          /*
          Positioned(
            top: 12.0,
            left: 12.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Text(
                "SlidingUpPanel Example",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 8.0)
                ],
              ),
            ),
          ),
          */
        ],
      ),
    );
  }

// パネル側のWidget
  Widget _panel(ScrollController sc) {



    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                //  children: <Widget>[
                    Text(
                      "岡崎公園",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 24.0,
                      ),
                    ),
                // ],
                //),
                /*
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button("Popular", Icons.favorite, Colors.blue),
                    _button("Food", Icons.restaurant, Colors.red),
                    _button("Events", Icons.event, Colors.amber),
                    _button("More", Icons.more_horiz, Colors.green),
                  ],
                ),
                */
                ]
            )
          ),
          Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),

                Text("Tweets",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )
                ),
                SizedBox(
                  height: 24.0,
                ),

              ]
            )
          ),



          Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                WebViewX(
                  key: const ValueKey('webviewx_tweet'),
                  initialContent: '<blockquote class="twitter-tweet" data-lang="ja" data-theme="dark"><p lang="ja" dir="ltr">まんぷく屋248<br>初めて極太麺にしてみた <a href="https://t.co/wG0Cr77PGH">pic.twitter.com/wG0Cr77PGH</a></p>&mdash; 東海ドライバー (@tokai_driver) <a href="https://twitter.com/tokai_driver/status/1528724033159962625?ref_src=twsrc%5Etfw">2022年5月23日</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
                  initialSourceType: SourceType.html,
                  height: 495,//サイズは適当
                  width: 360,//サイズは適当
                  //onWebViewCreated: (controller) => webviewController = controller,
                ),
                SizedBox(
                  height: 24.0,
                ),
                WebViewX(
                  key: const ValueKey('webviewx_tweet2'),
                  initialContent: '<blockquote class="twitter-tweet" data-lang="ja" data-theme="dark"><p lang="ja" dir="ltr">まんぷく家<br>特製ラーメン<br>まかないめし <a href="https://t.co/7fR5HPyXjC">pic.twitter.com/7fR5HPyXjC</a></p>&mdash; 東海ドライバー (@tokai_driver) <a href="https://twitter.com/tokai_driver/status/1490301682324209666?ref_src=twsrc%5Etfw">2022年2月6日</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>',
                  initialSourceType: SourceType.html,
                  height: 455,//サイズは適当
                  width: 360,//サイズは適当
                  //onWebViewCreated: (controller) => webviewController = controller,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text("関連動画",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )
                ),
                WebViewX(
                  key: const ValueKey('webviewx_youtube'),
                  initialContent: '<div class="responsive"><iframe width="100%" height="200" src="https://www.youtube.com/embed/tE2xt55_W8k" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
                  initialSourceType: SourceType.html,
                  height: 225,//サイズは適当
                  width: 360,//サイズは適当
                  //onWebViewCreated: (controller) => webviewController = controller,
                ),
                SizedBox(
                  height: 24.0,
                ),
                WebViewX(
                  key: const ValueKey('webviewx_youtube2'),
                  initialContent: '<div class="responsive"><iframe width="100%" height="200" src="https://www.youtube.com/embed/tE2xt55_W8k" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>',
                  initialSourceType: SourceType.html,
                  height: 225,//サイズは適当
                  width: 360,//サイズは適当
                  //onWebViewCreated: (controller) => webviewController = controller,
                )
              ],
            ),
          ),


          SizedBox(
            height: 24.0,
          ),



          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("関連動画",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    /*
                    CachedNetworkImage(
                      imageUrl:
                        "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                      height: 120.0,
                      width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                      fit: BoxFit.cover,
                    )
                     */
                    CachedNetworkImage(
                      imageUrl:
                        "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                      width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                      height: 120.0,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),

          /*
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("About",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  """岡崎公園 （おかざきこうえん）は、愛知県岡崎市にある公立の都市公園（歴史公園）である。
名鉄名古屋本線東岡崎駅の西方、岡崎城を中心とした歴史公園。春は桜の名所として知られる。
日本さくら名所100選に選定されている。夏は花火大会で賑わう。
Wikipedia
（中略）""",
                  softWrap: true,
                ),
              ],
            ),
          ),

           */
          SizedBox(
            height: 24,
          ),
        ],
      )
    );
  }

  /*
  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
          BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }
  */

// パネル裏のマップを表示するWidget
  Widget _body() {
    /*
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: FlutterMap(

     */
        return FlutterMap(
          options: MapOptions(
            center: LatLng(34.95667497205167, 137.1597907373678),
            zoom: 13.0,
            maxZoom: 17.0,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"),
            MarkerLayerOptions(markers: [
              Marker(
                  point: LatLng(34.95667497205167, 137.1597907373678),
                  /*
                  builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 36.0,
                  ),
                   */
                  builder: (context) => Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.location_on, //←任意のIconへ変更可能
                        size: 40,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {_pc.open();},
                    ),
                  height: 30,
                  )
              ),
            ]),
          ],
        );
    //);

  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FlutterMap(//https://www.azukipan.com/posts/flutter-map/
        options: MapOptions(
          center: latLng.LatLng(34.95667497205167, 137.1597907373678),
          zoom: 13.0,
          maxZoom: 17.0,
          minZoom: 3.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            retinaMode: true,
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: latLng.LatLng(34.95667497205167, 137.1597907373678),
                builder: (ctx) => const Icon(
                  Icons.location_pin,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ],
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      persistentFooterButtons: <Widget>[
        Center(
          child: RaisedButton(
            child: const Text('Reset'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: _resetCounter,
          ),
        ),
      ],
    );
  }
}
*/