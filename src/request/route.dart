import '../interop.dart';
import '../safe_response.dart';

abstract class RouteHandle {
  Future<JSResponse> request(List<String> args);
}
