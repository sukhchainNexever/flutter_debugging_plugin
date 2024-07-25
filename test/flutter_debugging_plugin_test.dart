import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_debugging_plugin/flutter_debugging_plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlutterDebuggingPlugin Tests', () {
    test('isUsbDebuggingEnabled returns a boolean', () async {
      // Mock the method channel to simulate method calls and responses
      const channel = MethodChannel('com.nexever/debugging');
      channel.setMethodCallHandler((MethodCall methodCall) async {
        return true; // Simulate that USB debugging is enabled
      });

      final result = await FlutterDebuggingPlugin.isUsbDebuggingEnabled;
      expect(result, isTrue);
    });

    test('isVpnConnected returns a boolean', () async {
      const channel = MethodChannel('com.nexever/debugging');
      channel.setMethodCallHandler((MethodCall methodCall) async {
        return true; // Simulate that VPN is connected
      });

      final result = await FlutterDebuggingPlugin.isVpnConnected;
      expect(result, isTrue);
    });

    test('isDeviceRooted returns a boolean', () async {
      const channel = MethodChannel('com.nexever/debugging');
      channel.setMethodCallHandler((MethodCall methodCall) async {
        return true; // Simulate that the device is rooted
      });

      final result = await FlutterDebuggingPlugin.isDeviceRooted;
      expect(result, isTrue);
    });
  });
}
