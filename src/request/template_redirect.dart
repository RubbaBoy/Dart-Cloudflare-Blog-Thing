import 'package:js/js_util.dart';

import '../constants.dart';
import '../fetch.dart';
import '../interop.dart' as inter;
import '../safe_response.dart';
import 'route.dart';

class TemplateRedirectRoute extends RouteHandle {

  @override
  Future<Response> request(List<String> args) async {
    var path = '$RAW_URL_PREFIX$TEMPLATE_REPO/${args.join('/')}';

    if (path.endsWith('.html') || path.endsWith('.css')) {
      var extension = path.substring(path.lastIndexOf('.') + 1, path.length);
      var response = await fetch(path);

      var contentType = {
        'css': MimeType.CSS,
        'html': MimeType.HTML
      }[extension] ?? MimeType(response.headers.get('Content-Type'));

      print('Request was with Content-Type: $contentType');

      return Response(
          await promiseToFuture(response.text()), mime: contentType);
    }

    return Response('', headers: {'Location': path},
        status: 308,
        statusText: 'Permanent Redirect');
  }
}
