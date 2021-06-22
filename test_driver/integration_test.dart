import 'dart:io' show Platform, Process;
import 'package:integration_test/integration_test_driver.dart';
import 'package:path/path.dart';

// Driver for the integration test.
Future<void> main() async {
  // Obtains storage permission on Android.
  Map<String, String> vars = Platform.environment;
  String path = join(vars['ANDROID_SDK_ROOT'] ?? vars['ANDROID_HOME'] as String, "platform-tools", Platform.isWindows ? "adb.exe" : "adb");
  await Process.run(path, [
    'shell',
    'pm',
    'grant',
    'com.example.fluttersample', 
    'android.permission.WRITE_EXTERNAL_STORAGE'
  ]);

  // Starts the driver.
  await integrationDriver();
}
