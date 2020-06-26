/*
 * flutter_sunmi_printer
 * Created by Andrey U.
 * 
 * Copyright (c) 2020. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'enums.dart';

/// Column contains text, align and width (an integer in 1..12 range)
class SunmiCol {
  SunmiCol({
    this.text = '',
    this.width = 2,
    this.align = SunmiAlign.left,
  }) {
    if (width < 1 || width > 12) {
      throw Exception('Column width must be between 1..12');
    }
  }

  String text;
  int width;
  SunmiAlign align;

  Map<String, String> toJson() {
    return {
      "text": text,
      "width": width.toString(),
      "align": align.value.toString(),
    };
  }
}
