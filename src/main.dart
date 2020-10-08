import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'constants.dart';
import 'fetch.dart';
import 'interop.dart';
import 'request/index.dart';
import 'request/post.dart';
import 'request_manager.dart';
import 'safe_response.dart';

final URL_END_REGEX = RegExp(r'[^\/:]\/(.*)');
final requestManager = RequestManager();
final contentTypes = {'css': MimeType.CSS, 'html': MimeType.HTML};

void main() {
  requestManager.addRoute('/', IndexRoute());
  requestManager.addRoute('/post/*', PostRoute());


  addEventListener('fetch', allowInterop((FetchEvent event) {
    event.passThroughOnException();

    // the abc of https://foo.example.com/abc
    var urlEnd = URL_END_REGEX.firstMatch(event.request.url).group(1);

    if (urlEnd.contains('.')) {
      event.respondWith(
          Promise<JSResponse>(allowInterop((resolve, reject) async {

        resolve((await handleRedirect(urlEnd)).toJS());
      })));
    } else {
      event.respondWith(Promise<JSResponse>(allowInterop((resolve, reject) =>
          requestManager
              .request(event.request)
              .then(resolve, onError: reject))));
    }
  }));
}

void respondWith(FetchEvent event, Function(void Function(JSResponse), Function reject) callback) {
  event.respondWith(Promise<JSResponse>(allowInterop(callback)));
}

Future<Response> handleRedirect(String urlEnd) async {
  var url = '$RAW_URL_PREFIX$TEMPLATE_REPO/$urlEnd';
  var extension = url.substring(url.lastIndexOf('.') + 1);

  if (contentTypes.keys.contains(extension)) {
    var res = await fetch(url);

    var contentType =
        contentTypes[extension] ?? MimeType(res.headers.get('Content-Type'));

    return Response(await promiseToFuture(res.text()), mime: contentType);
  } else {
    return Response('',
        headers: {'Location': url},
        status: 308,
        statusText: 'Permanent Redirect');
  }
}
