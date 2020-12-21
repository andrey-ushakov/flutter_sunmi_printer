/*
 * flutter_sunmi_printer
 * Created by Andrey U.
 * 
 * Copyright (c) 2020. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_sunmi_printer/src/enums.dart';
import 'sunmi_col.dart';
import 'sunmi_styles.dart';

class SunmiPrinter {
  static const String RESET = "reset";
  // static const String START_PRINT = "startPrint";
  // static const String STOP_PRINT = "stopPrint";
  // static const String IS_PRINTING = "isPrinting";
  static const String BOLD_ON = "boldOn";
  static const String BOLD_OFF = "boldOff";
  static const String UNDERLINE_ON = "underlineOn";
  static const String UNDERLINE_OFF = "underlineOff";
  static const String EMPTY_LINES = "emptyLines";
  static const String PRINT_TEXT = "printText";
  static const String PRINT_ROW = "printRow";
  static const String PRINT_IMAGE = "printImage";
  static const String CUT_PAPER = "cutPaper";

  static const MethodChannel _channel =
      const MethodChannel('flutter_sunmi_printer');

  static Future<void> reset() async {
    await _channel.invokeMethod(RESET);
  }

  // static Future<void> startPrint() async {
  //   await _channel.invokeMethod(START_PRINT);
  // }

  // static Future<void> stopPrint() async {
  //   await _channel.invokeMethod(STOP_PRINT);
  // }

  // static Future<void> isPrinting() async {
  //   await _channel.invokeMethod(IS_PRINTING);
  // }

  /// Print [text] with [styles] and skip [linesAfter] after
  static Future<void> text(
    String text, {
    SunmiStyles styles = const SunmiStyles(),
    int linesAfter = 0,
  }) async {
    await _channel.invokeMethod(PRINT_TEXT, {
      "text": text,
      "bold": styles.bold,
      "underline": styles.underline,
      "align": styles.align.value,
      "size": styles.size.value,
      "linesAfter": linesAfter,
    });
  }

  /// Skip [n] lines
  static Future<void> emptyLines(int n) async {
    if (n > 0) {
      await _channel.invokeMethod(EMPTY_LINES, {"n": n});
    }
  }

  /// Print horizontal full width separator
  static Future<void> hr({
    String ch = '-',
    int len = 31,
    linesAfter = 0,
  }) async {
    await text(List.filled(len, ch[0]).join(), linesAfter: linesAfter);
  }

  /// Print a row.
  ///
  /// A row contains up to 12 columns. A column has a width between 1 and 12.
  /// Total width of columns in one row must be equal to 12.
  static Future<void> row({
    List<SunmiCol> cols,
    bool bold: false,
    bool underline: false,
    SunmiSize textSize: SunmiSize.md,
    int linesAfter: 0,
  }) async {
    final isSumValid = cols.fold(0, (int sum, col) => sum + col.width) == 12;
    if (!isSumValid) {
      throw Exception('Total columns width must be equal to 12');
    }

    final colsJson = List<Map<String, String>>.from(
        cols.map<Map<String, String>>((SunmiCol col) => col.toJson()));

    await _channel.invokeMethod(PRINT_ROW, {
      "cols": json.encode(colsJson),
      "bold": bold,
      "underline": underline,
      "textSize": textSize.value,
      "linesAfter": linesAfter,
    });
  }

  static Future<void> boldOn() async {
    await _channel.invokeMethod(BOLD_ON);
  }

  static Future<void> boldOff() async {
    await _channel.invokeMethod(BOLD_OFF);
  }

  static Future<void> underlineOn() async {
    await _channel.invokeMethod(UNDERLINE_ON);
  }

  static Future<void> underlineOff() async {
    await _channel.invokeMethod(UNDERLINE_OFF);
  }

  static Future<void> image(
    String base64, {
    SunmiAlign align: SunmiAlign.center,
  }) async {
    await _channel.invokeMethod(PRINT_IMAGE, {
      "base64": base64,
      "align": align.value,
    });
  }

  static Future<void> cutPaper() async {
    await _channel.invokeMethod(CUT_PAPER);
  }
}
