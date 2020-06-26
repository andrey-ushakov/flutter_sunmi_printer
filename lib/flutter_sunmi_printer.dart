import 'dart:async';

import 'package:flutter/services.dart';

class FlutterSunmiPrinter {
  static const MethodChannel _channel =
      const MethodChannel('flutter_sunmi_printer');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
