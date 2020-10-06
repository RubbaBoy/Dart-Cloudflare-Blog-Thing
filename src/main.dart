import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'fetch.dart';
import 'interop.dart';
import 'request/index.dart';
import 'request/post.dart';
import 'request_manager.dart';
import 'safe_response.dart';

final URL_END_REGEX = RegExp(r'[^\/:]\/(.*)');
final requestManager = RequestManager();

void main() {
  requestManager.addRoute('/', IndexRoute());
  requestManager.addRoute('/post/*', PostRoute());

  final contentTypes = {
    'css': MimeType.CSS,
    'html': MimeType.HTML
  };

  addEventListener('fetch', allowInterop((FetchEvent event) {
    event.passThroughOnException();

    if (!event.request.url.contains('post')) {
      event.respondWith(
          Promise<JSResponse>(allowInterop((resolve, reject) async {
        var url = 'https://raw.githubusercontent.com/RubbaBoy/YarrisBlog/template/${URL_END_REGEX.firstMatch(event.request.url).group(1)}';
        print(url);
        var extension = url.substring(url.lastIndexOf('.') + 1);

        if (contentTypes.keys.contains(extension)) {
          var res = await fetch(url);

          var contentType = contentTypes[extension] ??
              MimeType(res.headers.get('Content-Type'));

          resolve(Response(await promiseToFuture(res.text()), mime: contentType).toJS());
        } else {
          resolve(Response('',
                  headers: {'Location': url},
                  status: 308,
                  statusText: 'Permanent Redirect')
              .toJS());
        }
      })));
    }

    event.respondWith(Promise<JSResponse>(allowInterop((resolve, reject) {
      return requestManager
          .request(event.request)
          .then(resolve, onError: reject);
    })));
  }));
}
