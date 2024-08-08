import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/player.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class SvgaPlayerPage extends StatefulWidget {
  const SvgaPlayerPage({super.key});

  @override
  State<SvgaPlayerPage> createState() => _SvgaPlayerPageState();
}

class _SvgaPlayerPageState extends State<SvgaPlayerPage> with SingleTickerProviderStateMixin {
  late SVGAAnimationController svgaController;

  @override
  void initState() {
    super.initState();
    svgaController = SVGAAnimationController(vsync: this);
  }

  @override
  void dispose() {
    svgaController.videoItem = null;
    svgaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SvgaPlayer")),
      body: _buildBody(),
      floatingActionButton: svgaController.videoItem == null ? null : FloatingActionButton.extended(
        onPressed: (){pauseAndResume();},
        label: Text(svgaController.isAnimating ? "Pause" : "Play"),
        icon: Icon(svgaController.isAnimating
            ? Icons.pause
            : Icons.play_arrow),

      ),
    );
  }


  _buildBody() {
    return Column(
      children: [
        ElevatedButton(onPressed: _startPlay, child: const Text("start Svga")),
        const SizedBox(height: 35),
        Container(
          width: 350,
          height: 350,
          color: Colors.black,
          child: SVGAImage(
            svgaController,
            fit: BoxFit.contain,
            clearsAfterStop: false,
            allowDrawingOverflow: true,
            filterQuality: FilterQuality.high,
            preferredSize: const Size(350,350),
          ),
        ),
        const SizedBox(height: 35),
        AnimatedBuilder(
            animation: svgaController,
            builder: (context, child) {
              return Text(
                  'Current frame: ${svgaController.currentFrame + 1}/${svgaController.frames}');
            }),
      ],
    );
  }

  _startPlay() async {
    svgaController.clear();
    svgaController.videoItem = null;
    MovieEntity? videoItem;
    await _decodeSvgaPath("assets/svga/angel.svga").then((value) => videoItem = value);
    if (mounted) {
      setState(() {
        svgaController.videoItem = videoItem;
        _playAnimation();
      });
    }
  }

  void _playAnimation() {
    if (svgaController.isCompleted == true) {
      svgaController.reset();
    }
    svgaController.repeat(); // or animationController.forward();
  }

  void pauseAndResume() {
    if (svgaController.isAnimating == true) {
      svgaController.stop();
    } else {
      _playAnimation();
    }
    setState(() {});
  }

  Future<MovieEntity> _decodeSvgaPath(String url) {
    if (url.startsWith(RegExp(r'https?://'))) {
      return SVGAParser.shared.decodeFromURL(url);
    } else {
      return SVGAParser.shared.decodeFromAssets(url);
    }
  }
}
