import '../safe_response.dart';
import 'route.dart';

class IndexRoute extends RouteHandle {

  @override
  Future<Response> request(List<String> args) async {
    return Response('Index!', mime: MimeType.HTML);
  }
}
