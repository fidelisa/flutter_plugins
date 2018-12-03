import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class VideoPlayerScaffold extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final String url;
  final List<Widget> persistentFooterButtons;
  final Widget bottomNavigationBar;

  const VideoPlayerScaffold(
      {Key key,
      this.appBar,
      @required this.url,
      this.persistentFooterButtons,
      this.bottomNavigationBar})
      : super(key: key);

  @override
  _VideoPlayerScaffoldState createState() => new _VideoPlayerScaffoldState();
}

class _VideoPlayerScaffoldState extends State<VideoPlayerScaffold> {
  final videoPlayerReference = new VideoVlcPlugin();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    videoPlayerReference.launch(widget.url);
    return new Scaffold(
        appBar: widget.appBar,
        persistentFooterButtons: widget.persistentFooterButtons,
        bottomNavigationBar: widget.bottomNavigationBar,
        body: const Center(child: const CircularProgressIndicator()));
  }
}

const _kChannel = 'video_vlc';

class VideoVlcPlugin {
  final _channel = const MethodChannel(_kChannel);

  static VideoVlcPlugin _instance;

  factory VideoVlcPlugin() => _instance ??= new VideoVlcPlugin._();

  VideoVlcPlugin._();

  Future<Null> launch(String url) async {
    final args = <String, dynamic>{'url': url};

    await _channel.invokeMethod('play', args);
  }

  /// Close all Streams
  void dispose() {
    _instance = null;
  }
}
