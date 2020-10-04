import '../interop.dart';
import '../safe_response.dart';

abstract class RouteHandle {
  Future<Response> request(List<String> args);
}
