import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/common/platformwidget.dart';


class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String mainaction;
  final String secondaction;

  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.mainaction,
      this.secondaction});

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (context) => this)
        : await showDialog<bool>(
            context: context,
            builder: (context) => this,
            barrierDismissible: false);
  }

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _dialogButtons(context),
    );
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _dialogButtons(context),
    );
  }

  List<Widget> _dialogButtons(BuildContext context) {
    final allButtons = <Widget>[];
    if (Platform.isIOS) {
      if (secondaction != null) {
        allButtons.add(CupertinoDialogAction(
          child: Text(secondaction),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ));
      }
      allButtons.add(CupertinoDialogAction(
        child: Text(mainaction),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ));
    } else {
      if (secondaction != null) {
        allButtons.add(TextButton(
          child: Text(secondaction),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ));
      }
      allButtons.add(TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(mainaction)));
    }
    return allButtons;
  }
}
