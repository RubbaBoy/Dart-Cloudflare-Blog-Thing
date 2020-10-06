import 'package:js/js.dart';

import 'interop.dart';
import 'request/index.dart';
import 'request/post.dart';
import 'request/template_redirect.dart';
import 'request_manager.dart';

final requestManager = RequestManager();

void main() {
  requestManager.addRoute('/', IndexRoute());
  requestManager.addRoute('/post/*', PostRoute());
  requestManager.addDefaultRoute(TemplateRedirectRoute());

  addEventListener(
      'fetch',
      allowInterop((FetchEvent event) => event.respondWith(Promise<JSResponse>(
          allowInterop((resolve, reject) {
            return requestManager
              .request(event.request)
              .then(resolve, onError: reject);
          })))));
}
