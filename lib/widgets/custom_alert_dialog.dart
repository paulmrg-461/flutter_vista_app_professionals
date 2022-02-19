import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog {
  Future<void> showCustomDialog(context, String title, String content,
      String cancelActionText, String actionText, VoidCallback action) async {
    return showDialog(
      context: context,
      builder: (context) => Platform.isAndroid
          ? _androidAlertDialog(
              context, title, content, cancelActionText, actionText, action)
          : _iOsAlertDialog(
              context, title, content, cancelActionText, actionText, action),
    );
  }

  AlertDialog _androidAlertDialog(
      BuildContext context,
      String title,
      String content,
      String cancelActionText,
      String actionText,
      VoidCallback action) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelActionText != ''
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.white,
                  shadowColor: Colors.blueAccent,
                  elevation: 0,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(cancelActionText,
                    style: const TextStyle(color: Colors.blueAccent)))
            : Container(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.white,
              shadowColor: Colors.blueAccent,
              elevation: 0,
            ),
            onPressed: action,
            child: Text(
              actionText,
              style: const TextStyle(color: Colors.blueAccent),
            )),
      ],
    );
  }

  CupertinoAlertDialog _iOsAlertDialog(
      BuildContext context,
      String title,
      String content,
      String cancelActionText,
      String actionText,
      VoidCallback action) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        cancelActionText != ''
            ? CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: Text(cancelActionText))
            : Container(),
        CupertinoButton(
            onPressed: () {
              action;
              Navigator.pop(context);
            },
            child: Text(actionText)),
      ],
    );
  }
}
