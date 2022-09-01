import 'item_context.dart';
import 'dart:convert';
import 'dart:io';

ItemContext getContext() {
  File('lib/data/skin_info.json').readAsString().then((String contents) {
    final parsedJson = jsonDecode(contents);
    final context = ItemContext.fromJson(parsedJson);
    return context;
  });
  throw '';
}
