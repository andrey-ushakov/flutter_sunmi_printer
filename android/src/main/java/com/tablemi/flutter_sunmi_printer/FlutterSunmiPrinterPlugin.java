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
  private String PRINT_ROW = "printRow";
  private String PRINT_IMAGE = "printImage";

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_sunmi_printer");
    channel.setMethodCallHandler(this);
    flutterSunmiPrinterModule = new FlutterSunmiPrinterModule();
    flutterSunmiPrinterModule.initAidl(flutterPluginBinding.getApplicationContext());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It
  // supports the old pre-Flutter-1.12 Android projects. You are encouraged to
  // continue supporting plugin registration via this function while apps migrate
  // to use the new Android APIs post-flutter-1.12 via
  // https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith
  // to keep them functionally equivalent. Only one of onAttachedToEngine or
  // registerWith will be called depending on the user's project.
  // onAttachedToEngine or registerWith must both be defined in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_sunmi_printer");
    channel.setMethodCallHandler(new FlutterSunmiPrinterPlugin());
    flutterSunmiPrinterModule = new FlutterSunmiPrinterModule();
    flutterSunmiPrinterModule.initAidl(registrar.context());
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
      int align = call.argument("align");
      boolean bold = call.argument("bold");
      boolean underline = call.argument("underline");
      int linesAfter = call.argument("linesAfter");
      int size = call.argument("size");
      flutterSunmiPrinterModule.text(text, align, bold, underline, size, linesAfter);
      result.success(null);
    } else if (call.method.equals(EMPTY_LINES)) {
      int n = call.argument("n");
      flutterSunmiPrinterModule.emptyLines(n);
      result.success(null);
    } else if (call.method.equals(PRINT_ROW)) {
      String cols = call.argument("cols");
      boolean bold = call.argument("bold");
      boolean underline = call.argument("underline");
      int textSize = call.argument("textSize");
      int linesAfter = call.argument("linesAfter");
      flutterSunmiPrinterModule.row(cols, bold, underline, textSize, linesAfter);
      result.success(null);
    } else if (call.method.equals(PRINT_IMAGE)) {
      String base64 = call.argument("base64");
      int align = call.argument("align");
      flutterSunmiPrinterModule.printImage(base64, align);
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
