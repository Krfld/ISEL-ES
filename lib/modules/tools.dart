import 'package:flutter/material.dart';
import 'dart:developer';

import '../.imports.dart';

class Tools {
  /// Delay function
  static Future delay({int seconds = 0, int milliseconds = 0}) async =>
      await Future.delayed(Duration(seconds: seconds, milliseconds: milliseconds));

  /// Load map value from path
  static dynamic _load(Map source, String path, var defaultValue) {
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

    /*if (out is num != defaultValue is num ||
        out is String != defaultValue is String ||
        out is bool != defaultValue is bool ||
        out is List != defaultValue is List ||
        out is Map != defaultValue is Map) out = defaultValue;*/

    return out;
  }

  static int loadInt(Map source, String path, int defaultValue) {
    var out = _load(source, path, defaultValue);
    return out is int ? out : defaultValue;
  }

  static double loadDouble(Map source, String path, double defaultValue) {
    var out = _load(source, path, defaultValue);
    return out is double ? out : defaultValue;
  }

  static String loadString(Map source, String path, String defaultValue) {
    var out = _load(source, path, defaultValue);
    return out is String ? out : defaultValue;
  }

  static bool loadBool(Map source, String path, bool defaultValue) {
    var out = _load(source, path, defaultValue);
    return out is bool ? out : defaultValue;
  }

  static List loadList(Map source, String path, List defaultValue) {
    var out = _load(source, path, defaultValue);
    return out is List ? out : defaultValue;
  }

  static Map loadMap(Map source, String path, Map defaultValue) {
    var out = _load(source, path, defaultValue);
    return out is Map ? out : defaultValue;
  }
}

class Log {
  static const String _tag = '+';
  static int _debugId = 0;

  static dynamic print(var msg, {String prefix = 'DEBUG', bool isError = false}) {
    if (isError) prefix = '{ERROR} ' + prefix;
    //debugPrint('$_tag[${prefix.toUpperCase()} (${_debugId++})] $msg');
    log('$msg', name: '$_tag ${prefix.toUpperCase()} (${_debugId++})');
    return msg;
  }
}
