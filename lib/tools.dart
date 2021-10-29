// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

final _App app = _App();

class _App {
  final String _tag = '+';
  int _debugID = 0;
  dynamic msg(var msg, {BuildContext? context, String prefix = 'DEBUG'}) {
    context == null
        ? print('$_tag[${prefix.toUpperCase()} (${_debugID++})] $msg')
        : print('$_tag{${context.widget} (${_debugID++})} $msg');
    return msg;
  }
}
