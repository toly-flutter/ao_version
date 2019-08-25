import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ao_version/ao_version.dart';

void main() {
  const MethodChannel channel = MethodChannel('ao_version');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AoVersion.platformVersion, '42');
  });
}
