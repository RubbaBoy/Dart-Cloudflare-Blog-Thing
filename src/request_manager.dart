import 'interop.dart';
import 'request/route.dart';
import 'safe_response.dart';

class RequestManager {
  static const EMPTY_ENTRY = MapEntry(null, null);
  final Map<String, RouteHandle> handles = {};
  RouteHandle defaultHandle;

  /// Adds a route to redirect to.
  ///
  /// /  -> index
  /// /post/whatever-is-here  ->  post('whatever-is-here')
  /// /tags  ->  tags
  /// /archive  ->  archive
  /// /search?tag=tag-here  ->  search(tag: 'tag-here')
  /// /search?query=anything-here  ->  search(query: 'anythin-here')
  ///
  /// Example routes:
  /// /one  ->  no params
  /// /two/*  ->  one param
  /// /three/*/*
  /// /three/*/whatever/*
  void addRoute(String route, RouteHandle handle) =>
      handles[route.substring(1)] = handle;

  void addDefaultRoute(RouteHandle handle) =>
      defaultHandle = handle;

  Future<JSResponse> request(JSRequest request) async {
    var requestSplit = request.url.split('/').skip(3).toList();
    if (requestSplit.last == '') {
      requestSplit.removeLast();
    }

    var handleEntry = handles.entries
        .map<MapEntry<List<String>, RouteHandle>>((entry) {
      var out = <String>[];

      var slashSplit = entry.key.split('/');
      if (requestSplit.length != slashSplit.length) {
        return EMPTY_ENTRY;
      }

      for (int i = 0; i < requestSplit.length; i++) {
        if (slashSplit[i] == '*') {
          out.add(requestSplit[i]);
        } else if (requestSplit[i] != slashSplit[i]) {
          return EMPTY_ENTRY;
        }
      }

      return MapEntry(out, entry.value);
    }).firstWhere((entry) => entry.value != null,
            orElse: () => MapEntry(requestSplit, defaultHandle));

    if (handleEntry.key == null) {
      return Response('Bad request!', mime: MimeType.HTML, status: 400).toJS();
    }

    return handleEntry.value
        .request(handleEntry.key);
  }
}
