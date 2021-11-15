import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import '../.imports.dart';

/// Loading widget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SpinKitChasingDots(color: Colors.teal, size: 64)));
  }
}

/// Button widget
class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function? onPressed;

  const Button(this.text, {@required this.icon, @required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(text, textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(112, 0),
        elevation: 4,
        padding: EdgeInsets.all(16),
        textStyle: TextStyle(fontSize: 14),
        //splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(64))),
      ),
      onPressed: onPressed != null ? () => onPressed?.call() : null,
    );
  }
}
