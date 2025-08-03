import 'package:flutter/material.dart';

class Notification_alert extends StatelessWidget {
  final List<String> notifications;

  Notification_alert({required this.notifications, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: notifications.isEmpty
          ? Center(child: Text('No notifications available'))
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notification_important, color: Colors.red),
            title: Text(notifications[index]),
          );
        },
      ),
    );
  }
}