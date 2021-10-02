import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlert {
  final String title;
  final String message;

  PlatformAlert({required this.title, required this.message});

  void show(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      _buildCupertinoAlert(context);
    } else {
      _buildMaterialAlert(context);
    }
  }

  void _buildCupertinoAlert(BuildContext context) => showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );

  void _buildMaterialAlert(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
}
