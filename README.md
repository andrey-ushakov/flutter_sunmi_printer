# flutter_sunmi_printer

Plugin allows to print thermal receipts using Sunmi device with a built-in printer. Tested on Sunmi V2.

## Features

- `text`: print text with styles (bold, underline, align, font size)
- `row`: print a row containing up to 12 columns (total columns width must be equal to 12)
- `image`: print an image with alignment
- `hr`: print full width separator
- `emptyLines`: feed _n_ lines
- `boldOn`, `boldOff`
- `underlineOn`, `underlineOff`

## TODO

- Print QR codes
- Print Barcodes

## Getting Started

```dart
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';

// Test regular text
SunmiPrinter.hr(); // prints a full width separator
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
```
