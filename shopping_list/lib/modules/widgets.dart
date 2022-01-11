import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Loading
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, body: Center(child: SpinKitChasingDots(color: Colors.teal, size: 64)));
  }
}

/// Button
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
        padding: EdgeInsets.all(20),
        minimumSize: Size(128, 0),
        // textStyle: TextStyle(fontSize: 16),
        //splashFactory: InkRipple.splashFactory,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(64))),
      ),
      onPressed: onPressed != null ? () => onPressed?.call() : null,
    );
  }
}

/// PopUp Button
class PopUpButton extends StatelessWidget {
  final String text;
  final bool warning;
  final Function? onPressed;

  const PopUpButton(this.text, {this.warning = false, @required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text, textAlign: TextAlign.center),
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: EdgeInsets.all(12),
        minimumSize: Size(64 + 16, 0),
        primary: warning ? Colors.redAccent : Colors.teal,
      ),
      onPressed: onPressed != null ? () => onPressed?.call() : null,
    );
  }
}

/// PopUp
class PopUp extends StatelessWidget {
  final Widget title;
  final Widget? content;
  final List<Widget>? actions;

  const PopUp({required this.title, this.content, this.actions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: actions,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
      actionsPadding: EdgeInsets.only(bottom: 16),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

/// Name
class Name extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final double? fontSize;

  const Name(this.text, {this.alignment = Alignment.centerLeft, this.fontSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: alignment,
      child: Text(text, style: TextStyle(fontSize: fontSize)), //, textAlign: TextAlign.center
    );
  }
}

//TODO
class Toast extends StatelessWidget {
  final BuildContext context;

  const Toast(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
