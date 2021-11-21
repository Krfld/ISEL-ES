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
  final IconData icon;
  final Function? onPressed;

  const Button(this.text, {required this.icon, @required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(text, textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
        elevation: 4,
        minimumSize: Size(128, 0),
        padding: EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 14),
        //splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(64))),
      ),
      onPressed: onPressed != null ? () => onPressed?.call() : null,
    );
  }
}

class PopUp extends StatelessWidget {
  final String title;
  final Widget? content;
  final List<Widget>? actions;

  const PopUp({required this.title, this.content, this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text(title),
      content: content,
      actions: actions,
    );
  }
}
