import 'dart:convert';

import 'interop.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart' as js;

@JS('fetch')
external Promise<JSResponse> _fetch(String url);

Future<JSResponse> fetch(String url) async =>
    await js.promiseToFuture<JSResponse>(fetch(url));

Future<String> fetchString(String url) async =>
    await (await fetch(url)).text();

Future<Map<String, dynamic>> fetchJSON(String url) async =>
    jsonDecode(await fetchString(url));
