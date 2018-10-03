// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// An example of using the plugin, controlling lifecycle and playback of the
/// video.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_vlc/video_vlc.dart';

var kRtsp = "rtsp://184.72.239.149/vod/mp4:BigBuckBunny_175k.mov";
var kVdo = "http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4";

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter WebView Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => const MyHomePage(title: 'Flutter WebView Demo'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Instance of WebView plugin
  final videoVlcPlugin = new VideoVlcPlugin();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    videoVlcPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new RaisedButton(
              onPressed: () {
                videoVlcPlugin.launch(kVdo);
              },
              child: const Text('Open video (mp4)'),
            ),
            new RaisedButton(
              onPressed: () {
                videoVlcPlugin.launch(kRtsp);
              },
              child: const Text('Open stream (rtsp)'),
            ),
          ],
        ),
      ),
    );
  }
}
