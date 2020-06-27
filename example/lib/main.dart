import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
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
  void _print() async {
    // Test regular text
    SunmiPrinter.hr();
    SunmiPrinter.text(
      'Test Sunmi Printer',
      styles: SunmiStyles(align: SunmiAlign.center),
    );
    SunmiPrinter.hr();

    // Test align
    SunmiPrinter.text(
      'left',
      styles: SunmiStyles(bold: true, underline: true),
    );
    SunmiPrinter.text(
      'center',
      styles:
          SunmiStyles(bold: true, underline: true, align: SunmiAlign.center),
    );
    SunmiPrinter.text(
      'right',
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.right),
    );

    // Test text size
    SunmiPrinter.text('Extra small text',
        styles: SunmiStyles(size: SunmiSize.xs));
    SunmiPrinter.text('Medium text', styles: SunmiStyles(size: SunmiSize.md));
    SunmiPrinter.text('Large text', styles: SunmiStyles(size: SunmiSize.lg));
    SunmiPrinter.text('Extra large text',
        styles: SunmiStyles(size: SunmiSize.xl));

    // Test row
    SunmiPrinter.row(
      cols: [
        SunmiCol(text: 'col1', width: 4),
        SunmiCol(text: 'col2', width: 4, align: SunmiAlign.center),
        SunmiCol(text: 'col3', width: 4, align: SunmiAlign.right),
      ],
    );

    // Test image
    ByteData bytes = await rootBundle.load('assets/rabbit_black.jpg');
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.emptyLines(3);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Sunmi Printer'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Center(
              child: RaisedButton(
                onPressed: _print,
                child: const Text('Print demo', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
