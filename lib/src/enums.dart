/*
 * flutter_sunmi_printer
 * Created by Andrey U.
 * 
 * Copyright (c) 2020. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

class SunmiAlign {
  const SunmiAlign._internal(this.value);
  final int value;
  static const left = SunmiAlign._internal(0);
  static const center = SunmiAlign._internal(1);
  static const right = SunmiAlign._internal(2);
}
