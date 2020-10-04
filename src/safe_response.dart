import 'interop.dart';

class Response {
  final String body;
  final MimeType mimeType;
  final int status;
  final String statusText;
  final Map<String, String> headers;

  Response(this.body, this.mimeType, {Map<String, String> headers = const {}, this.status = 200, this.statusText = 'OK'}) :
      headers = {'Content-Type': mimeType.value, ...headers};

  JSResponse toJS() => JSResponse(
      body,
      mapToJSObj({
        'status': status,
        'statusText': statusText,
        'headers': mapToJSObj(headers)
      }));
}

class MimeType {
  static const JSON = MimeType('application/json');
  static const HTML = MimeType('plain/html');

  final String value;

  const MimeType(this.value);
}
