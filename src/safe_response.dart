import 'interop.dart';

class Response {
  static final NOT_FOUND = Response('body',
      mime: MimeType.JSON, status: 404, statusText: 'Not Found');

  final String body;
  final MimeType mime;
  final int status;
  final String statusText;
  final Map<String, String> headers;

  Response(this.body,
      {this.mime,
      Map<String, String> headers = const {},
      this.status = 200,
      this.statusText = 'OK'})
      : headers = {if (mime != null) 'Content-Type': mime.value, ...headers};

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
  static const HTML = MimeType('text/html');
  static const CSS = MimeType('text/css');

  final String value;

  const MimeType(this.value);

  @override
  String toString() => 'MimeType[$value]';
}
