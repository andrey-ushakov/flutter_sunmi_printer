/*
 * flutter_sunmi_printer
 * Created by Andrey U.
 * 
 * Copyright (c) 2020. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'enums.dart';

/// Text styles
class SunmiStyles {
  const SunmiStyles({
    this.bold = false,
    this.underline = false,
    this.align = SunmiAlign.left,
  });

  // Init all fields with default values
  const SunmiStyles.defaults({
    this.bold: false,
    this.underline: false,
    this.align: SunmiAlign.left,
  });

  final bool bold;
  final bool underline;
  final SunmiAlign align;

  SunmiStyles copyWith({
    bool bold,
    bool underline,
    SunmiAlign align,
  }) {
    return SunmiStyles(
      bold: bold ?? this.bold,
      underline: underline ?? this.underline,
      align: align ?? this.align,
    );
  }
}
