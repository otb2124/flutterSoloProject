import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5, // Number of notifications
        itemBuilder: (context, index) {
          // Generate unique user names and tags
          String userName = 'user${index + 1}';
          String userTag = 'user${index + 1}';

          // Replace with your notification data
          return _buildNotificationListItem(context, userName, userTag);
        },
      ),
    );
  }

  Widget _buildNotificationListItem(
      BuildContext context, String userName, String userTag) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0), // Adjust vertical padding
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 0.0), // Remove default content padding
        leading: CircleAvatar(
          child: Icon(Icons.person), // Set profile picture icon
          radius: 20.0, // Set profile picture radius
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                '$userName ($userTag) reminds you about the task Task at Team WebDev deadline - 21 May 2020',
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make username and tag bold
                  color: Colors.black, // Set username and tag text color
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          // Handle notification tap
        },
      ),
    );
  }
}
