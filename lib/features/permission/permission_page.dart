import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PermissionView();
  }
}

class PermissionView extends StatelessWidget {
  const PermissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Denied'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Location access is denied. Click button below to change permission in setting menu',
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Text('Open Setting'),
          ),
        ],
      ),
    );
  }
}
