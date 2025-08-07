import 'dart:developer';

import 'package:example/service/mock_net.dart';

class MockService {
  MockService({required this.mockNet});
  final MockNet mockNet;

  Future<String> getHelloWorld() async {
    log(mockNet.getUrl());
    await Future.delayed(Duration(milliseconds: 500));
    // Mock service
    return "Hello World";
  }
}
