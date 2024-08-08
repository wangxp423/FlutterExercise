import 'package:flutter/material.dart';
import 'package:test_flutter/controller/container_loading_view_controller.dart';
import 'package:test_flutter/widgets/container_loading_view.dart';

class TestContainerLoadingPage extends StatefulWidget {
  const TestContainerLoadingPage({super.key});

  @override
  State<TestContainerLoadingPage> createState() => _TestContainerLoadingPageState();
}

class _TestContainerLoadingPageState extends State<TestContainerLoadingPage> {
  ContainerLoadingViewController controller = ContainerLoadingViewController();

  @override
  void initState() {
    super.initState();
    print("testxp.TestContainerLoadingPage.initState");
  }

  @override
  Widget build(BuildContext context) {
    print("testxp.TestContainerLoadingPage.build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestContainerLoadingPage"),
      ),
      body: ContainerLoadingView(
        controller: controller,
        contentWidget: Container(
          color: Colors.yellow,
          alignment: Alignment.center,
          child: Text("这里是内容正文"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showContent,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showContent() {
    controller.showContent(true);
  }
}
