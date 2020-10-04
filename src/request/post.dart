import '../interop.dart';
import '../safe_response.dart';
import 'route.dart';

class PostRoute extends RouteHandle {

  @override
  Future<Response> request(List<String> args) async {
    return Response('Showing post: ${args[0]}', MimeType.HTML);
  }
}
