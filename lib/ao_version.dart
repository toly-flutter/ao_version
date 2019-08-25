import 'dart:async';

import 'package:flutter/services.dart';

class AoVersion {
  static const MethodChannel _channel =
      const MethodChannel('ao_version');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> toast() async {//弹出吐司
     return _channel.invokeMethod('toast');
  }
}
