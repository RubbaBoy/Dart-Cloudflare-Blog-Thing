import 'dart:convert';

import 'interop.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('fetch')
external Promise<JSResponse> _fetch(String url);

Future<JSResponse> fetch(String url) async =>
    await promiseToFuture<JSResponse>(_fetch(url));

Future<String> fetchString(String url) async =>
    await promiseToFuture((await fetch(url)).text());

Future<Map<String, dynamic>> fetchJSON(String url) async =>
    jsonDecode(await fetchString(url));
