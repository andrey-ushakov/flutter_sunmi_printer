package com.tablemi.flutter_sunmi_printer;

import android.content.Context;

import com.tablemi.flutter_sunmi_printer.utils.AidlUtil;
import com.tablemi.flutter_sunmi_printer.utils.Base64Utils;
import com.tablemi.flutter_sunmi_printer.utils.BitmapUtil;
import com.tablemi.flutter_sunmi_printer.utils.ESCUtil;

public class FlutterSunmiPrinterModule {

    private static boolean isPrinting = false;
    // public static int SMALL_FONT_SIZE = 18;
    // public static int DEFAULT_FONT_SIZE = 24;
    // public static int LARGE_FONT_SIZE = 36;

    public void initAidl(Context context) {
        AidlUtil.getInstance().connectPrinterService(context);
        AidlUtil.getInstance().initPrinter();
    }

    public void reset() {
        AidlUtil.getInstance().initPrinter();
    }

    public void startPrint() {
        isPrinting = true;
    }

    public void stopPrint() {
        isPrinting = false;
    }

    public boolean isPrinting() {
        return isPrinting;
    }

    public void boldOn() {
        AidlUtil.getInstance().sendRawData(ESCUtil.boldOn());
    }

    public void boldOff() {
        AidlUtil.getInstance().sendRawData(ESCUtil.boldOff());
    }

    public void underlineOn() {
        AidlUtil.getInstance().sendRawData(ESCUtil.underlineWithOneDotWidthOn());
    }

    public void underlineOff() {
        AidlUtil.getInstance().sendRawData(ESCUtil.underlineOff());
    }

    public void emptyLines(int n) {
        AidlUtil.getInstance().lineWrap(n);
    }

    public void text(String text, int align, Boolean bold, Boolean underline, int linesAfter) {
        // Set styles
        if (bold) {
            boldOn();
        }
        if (underline) {
            underlineOn();
        }

        // Print text
        AidlUtil.getInstance().printTableItem(new String[] { text }, new int[] { 32 }, new int[] { align });
        if (linesAfter > 0) {
            emptyLines(linesAfter);
        }

        // Reset styles
        boldOff();
        underlineOff();
    }
}
