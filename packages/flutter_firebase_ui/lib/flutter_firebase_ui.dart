import 'dart:async';

import 'package:flutter/services.dart';

class FlutterFirebaseUi {
  static const MethodChannel _channel =
      const MethodChannel('flutter_firebase_ui');

  static Future<String> get platformVersion =>
      _channel.invokeMethod('getPlatformVersion');
}
