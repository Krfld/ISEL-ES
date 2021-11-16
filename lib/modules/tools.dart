import 'package:flutter/material.dart';

import '../.imports.dart';

final _App app = _App();

class _App {
  /// Delay function
  Future delay({int seconds = 0, int milliseconds = 0}) async =>
      await Future.delayed(Duration(seconds: seconds, milliseconds: milliseconds));

  /// Load map value from path
  dynamic load(var source, String path, var defaultValue) {
    path = path != '/'
        ? path.substring(path.startsWith('/') ? 1 : 0, path.endsWith('/') ? path.length - 1 : path.length)
        : '';

    List paths = path.split('/');
    paths.removeWhere((element) => element.isEmpty);

    dynamic out = source;

    if (paths.isNotEmpty)
      try {
        for (int i = 0; i < paths.length - 1; i++) out = out[paths[i]];
        out = out[paths.last];
      } catch (e) {
        out = defaultValue;
      }

    if (out is num != defaultValue is num ||
        out is String != defaultValue is String ||
        out is bool != defaultValue is bool ||
        out is List != defaultValue is List ||
        out is Map != defaultValue is Map) out = defaultValue;

    return out;
  }

  /// Debug
  final String _tag = '+';
  int _debugId = 0;
  dynamic msg(var msg, {String prefix = 'DEBUG', bool isError = false}) {
    if (isError) prefix = '{ERROR} ' + prefix;
    debugPrint('$_tag[${prefix.toUpperCase()} (${_debugId++})] $msg'); // Explore 'log'
    return msg;
  }
}
