import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  Future<void> showCustomDialog(
      context, String title, String content, String actionText) async {
    return showDialog(
      context: context,
      builder: (context) => Platform.isAndroid
          ? _androidAlertDialog(context, title, content, actionText)
          : _iOsAlertDialog(context, title, content, actionText),
    );
  }

  AlertDialog _androidAlertDialog(
      BuildContext context, String title, String content, String actionText) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text(actionText))
      ],
    );
  }

  CupertinoAlertDialog _iOsAlertDialog(
      BuildContext context, String title, String content, String actionText) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        CupertinoButton(
            onPressed: () => Navigator.pop(context), child: Text(actionText))
      ],
    );
  }
}
