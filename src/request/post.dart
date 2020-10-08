import 'package:js/js_util.dart';

import '../constants.dart';
import '../fetch.dart';
import '../interop.dart';
import '../safe_response.dart';
import 'route.dart';

class PostRoute extends RouteHandle {

  @override
  Future<JSResponse> request(List<String> args) async {
    final post = args[0];
    // var pageContent = await fetchString('$RAW_URL_PREFIX$CONTENT_REPO/posts/$post.md');
    var pageHTML = await fetch('$RAW_URL_PREFIX$TEMPLATE_REPO/post.html');
    // var done = pageHTML.replaceAll('%content%', pageContent);

    // return HTMLRewriter()
    //     .on('*', ElementHandler())
    //     .transform(pageHTML);

    var called = callConstructor('HTMLRewriter', []);
    print('called = $called is ${called.runtimeType}');

    return Response('done', mime: MimeType.HTML).toJS();
  }
}
