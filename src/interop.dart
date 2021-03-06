import 'package:js/js.dart';
import 'package:js/js_util.dart';

// Appended from bottom

@JS('console.log')
external void log(String foo);

@JS('Request')
class JSRequest {
  external String get url;
  external Headers get headers;
}

@JS('Response')
class JSResponse {
  external factory JSResponse(String body, Object init);

  external Promise<String> text();
  external Headers get headers;
}

@JS()
class FetchEvent {
  external JSRequest get request;

  external void passThroughOnException();
  external void respondWith(Promise<JSResponse> r);
  external void waitUntil(Promise<JSResponse> r);
}

@JS()
class Headers {
  external Map<String, String> get headers;

  external factory Headers(Map<String, String> headers);

  external void append(String name, String value);

  external void delete(String name);

  external String get(String name);

  external bool has(String name);

  external void set(String name, String value);
}

@JS()
class Promise<T> {
  external Promise(void executor(void resolve(T result), Function reject));

  external Promise then(void onFulfilled(T result), [Function onRejected]);
}

@JS()
external void addEventListener(String type, void Function(FetchEvent event));

Object mapToJSObj(Map<dynamic, dynamic> a) {
  var object = newObject();
  a.forEach((k, v) => setProperty(object, k, v));
  return object;
}

// CF Worker interop

class ElementHandler {
  void element(dynamic element) {
    print('Incoming element: $element');
  }

  void comments(dynamic comment) {
    print('Comment $comment');
  }

  void text(dynamic text) {
    print('text $text');
  }
}

@JS()
class HTMLRewriter {
  external HTMLRewriter on(String selector, dynamic handler);
  external JSResponse transform(JSResponse response);
}
