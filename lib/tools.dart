import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final _App app = _App();

class _App {
  Future delay({int seconds = 0, int milliseconds = 0}) async =>
      await Future.delayed(Duration(seconds: seconds, milliseconds: milliseconds));

  dynamic load(Map source, String path, var defaultValue) {
    path = path.substring(path.startsWith('/') ? 1 : 0, path.endsWith('/') ? path.length - 1 : path.length);

    List paths = path.split('/');

    dynamic out = source;

    try {
      for (int i = 0; i < paths.length - 1; i++) out = out[paths[i]] ?? {};
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

  final String _tag = '+';
  int _debugID = 0;
  dynamic msg(var msg, {BuildContext? context, String prefix = 'DEBUG'}) {
    context == null
        ? print('$_tag[${prefix.toUpperCase()} (${_debugID++})] $msg')
        : print('$_tag{${context.widget} (${_debugID++})} $msg');
    return msg;
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SpinKitChasingDots(color: Colors.teal, size: 64)));
  }
}
