import 'package:flutter/material.dart';
import 'package:test_flutter/controller/container_loading_view_controller.dart';

class ContainerLoadingView extends StatefulWidget {
  final ContainerLoadingViewController controller;
  final Widget contentWidget;

  const ContainerLoadingView({super.key,required this.controller,required this.contentWidget});

  @override
  State<ContainerLoadingView> createState() => _ContainerLoadingViewState();
}

class _ContainerLoadingViewState extends State<ContainerLoadingView> {
  late PageStatus status;

  @override
  void initState() {
    super.initState();
    print("testxp.ContainerLoadingView.initState");
    status = widget.controller.status;
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          status = widget.controller.status;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("testxp.ContainerLoadingView.build");
    return _buildBody();
  }

  _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          status == PageStatus.loading ? _loadingView() : widget.contentWidget
        ],
      ),
    );
  }

  _loadingView() {
    return Container(
      alignment: Alignment.center,
      color: Colors.green,
      child: Text("Loading View"),
    );
  }
}
