import 'package:js/js.dart';
import 'package:js/js_util.dart' as js;

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

  external String text();
  external Headers get headers;
}

@JS()
class FetchEvent {
  external JSRequest get request;

  external void respondWith(Promise<JSResponse> r);
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
  var object = js.newObject();
  a.forEach((k, v) => js.setProperty(object, k, v));
  return object;
}
