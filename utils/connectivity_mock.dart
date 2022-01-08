import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class ConnectivityMock {
  final TestWidgetsFlutterBinding binding;

  ConnectivityMock(this.binding);

  void setup() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
        MethodChannel('dev.fluttercommunity.plus/connectivity'),
        (MethodCall methodCall) async {
      // ignore: avoid_print
      print(
          '>>>>>>>>>>  dev.fluttercommunity.plus/connectivity  >>>>>>>>>>>>>>>> methodCall.method: ${methodCall.method}');
      if (methodCall.method == 'check') {
        return 'wifi';
      }
      return null;
    });
  }

  void sendPlatformMessageToFramework(String value) {
    const codec = StandardMethodCodec();
    binding.channelBuffers.push('dev.fluttercommunity.plus/connectivity_status',
        codec.encodeSuccessEnvelope(value), (ByteData? _) {});
  }
}
