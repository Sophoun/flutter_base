class MockService {
  Future<String> getHelloWorld() async {
    await Future.delayed(Duration(milliseconds: 500));
    // Mock service
    return "Hello World";
  }
}
