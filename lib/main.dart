import 'package:flutter/material.dart';
import 'package:test_flutter/page/svga_player_page.dart';
import 'package:test_flutter/page/test_container_loading_page.dart';

void main() {
  runApp(const MyApp());
}

Map<String, WidgetBuilder> _routes = {
  "containerLoadingPage": (context) => const TestContainerLoadingPage(),
  "svgaPlayerPage": (context) => const SvgaPlayerPage(),
};

Route<dynamic>? _generateRoute(RouteSettings settings) {
  final String? name = settings.name;
  final Widget Function(BuildContext)? pageRouteBuilder = _routes[name];
  if (pageRouteBuilder != null) {
    if (name == 'popWindow') {
      return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, _, __) => pageRouteBuilder(context),
        settings: settings,
      );
    }
    final Route<dynamic> route = MaterialPageRoute(
      builder: pageRouteBuilder,
      settings: settings,
    );
    return route;
  } else {
    return null;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: _generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    print("testxp._incrementCounter");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            _toContainerLoadingPageWidget(),
            _toSvgaPlayerPage()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  //测试ContainerLoading
  _toContainerLoadingPageWidget() {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "containerLoadingPage");
      },
      child: Container(
        width: 300,
        height: 45,
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        color: Colors.grey,
        child: const Text(
          'to ContainerLoadingPage',
        ),
      ),
    );
  }

  //测试svgaPlayer
  _toSvgaPlayerPage() {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "svgaPlayerPage");
      },
      child: Container(
        width: 300,
        height: 45,
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        color: Colors.grey,
        child: const Text(
          'to svgaPlayerPage',
        ),
      ),
    );
  }
}
