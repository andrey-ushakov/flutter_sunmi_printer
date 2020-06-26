import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void _print() async {
    // SunmiPrinter.startPrint();
    // SunmiPrinter.reset();
    SunmiPrinter.text(
      'left Underline',
      styles: SunmiStyles(bold: false, underline: true, align: SunmiAlign.left),
      // linesAfter: 0,
    );
    SunmiPrinter.text(
      'center Bold',
      styles:
          SunmiStyles(bold: true, underline: false, align: SunmiAlign.center),
      // linesAfter: 1,
    );
    SunmiPrinter.text(
      'right',
      styles:
          SunmiStyles(bold: false, underline: false, align: SunmiAlign.right),
      // linesAfter: 2,
    );
    // SunmiPrinter.stopPrint();
    SunmiPrinter.hr();
    SunmiPrinter.emptyLines(2);
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // try {
    //   platformVersion = await SunmiPrinter.platformVersion;
    // } on PlatformException {
    platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            RaisedButton(
              onPressed: _print,
              child: const Text('Print', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}
