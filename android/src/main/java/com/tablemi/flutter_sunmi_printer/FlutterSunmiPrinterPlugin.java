package com.tablemi.flutter_sunmi_printer;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterSunmiPrinterPlugin implements FlutterPlugin, MethodCallHandler {
  private MethodChannel channel;
  private static FlutterSunmiPrinterModule flutterSunmiPrinterModule;

  private String RESET = "reset";
  private String START_PRINT = "startPrint";
  private String STOP_PRINT = "stopPrint";
  private String IS_PRINTING = "isPrinting";
  private String BOLD_ON = "boldOn";
  private String BOLD_OFF = "boldOff";
  private String UNDERLINE_ON = "underlineOn";
  private String UNDERLINE_OFF = "underlineOff";
  private String EMPTY_LINES = "emptyLines";
  private String PRINT_TEXT = "printText";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_sunmi_printer");
    channel.setMethodCallHandler(this);
    flutterSunmiPrinterModule = new FlutterSunmiPrinterModule();
    flutterSunmiPrinterModule.initAidl(flutterPluginBinding.getApplicationContext());
  }

  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_sunmi_printer");
    channel.setMethodCallHandler(new FlutterSunmiPrinterPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals(RESET)) {
      flutterSunmiPrinterModule.reset();
      result.success(null);
    } else if (call.method.equals(START_PRINT)) {
      flutterSunmiPrinterModule.startPrint();
      result.success(null);
    } else if (call.method.equals(STOP_PRINT)) {
      flutterSunmiPrinterModule.stopPrint();
      result.success(null);
    } else if (call.method.equals(IS_PRINTING)) {
      result.success(flutterSunmiPrinterModule.isPrinting());
    } else if (call.method.equals(BOLD_ON)) {
      flutterSunmiPrinterModule.boldOn();
      result.success(null);
    } else if (call.method.equals(BOLD_OFF)) {
      flutterSunmiPrinterModule.boldOff();
      result.success(null);
    } else if (call.method.equals(UNDERLINE_ON)) {
      flutterSunmiPrinterModule.underlineOn();
      result.success(null);
    } else if (call.method.equals(UNDERLINE_OFF)) {
      flutterSunmiPrinterModule.underlineOff();
      result.success(null);
    } else if (call.method.equals(PRINT_TEXT)) {
      String text = call.argument("text");
      Integer align = call.argument("align");
      Boolean bold = call.argument("bold");
      Boolean underline = call.argument("underline");
      Integer linesAfter = call.argument("linesAfter");
      flutterSunmiPrinterModule.text(text, align, bold, underline, linesAfter);
      result.success(null);
    } else if (call.method.equals(EMPTY_LINES)) {
      Integer n = call.argument("n");
      flutterSunmiPrinterModule.emptyLines(n);
      result.success(null);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
