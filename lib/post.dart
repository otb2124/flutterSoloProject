import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final IconData profilePicture;
  final String name;
  final String userTag;
  final String date;
  final String description;
  final double progress; // New property for progress

  const PostWidget({
    Key? key,
    required this.profilePicture,
    required this.name,
    required this.userTag,
    required this.date,
    required this.description,
    required this.progress, // Include progress in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0), // Add vertical padding
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Colors.green, width: 2.0), // Apply bottom border
          ),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 12.0), // Add space at top and bottom of border
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(), // Build the header section
            SizedBox(height: 8.0), // Add space between header and description
            _buildDescription(), // Build the description section
            SizedBox(
                height: 12.0), // Add space between description and progress bar
            _buildProgressBar(), // Build the progress bar
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return ListTile(
      leading: Icon(profilePicture, size: 40.0), // Adjust the size here
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            userTag,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
      trailing: Text(
        date,
        style: TextStyle(fontSize: 12.0),
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding
      child: Text(
        description,
        style: TextStyle(fontSize: 14.0),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: LinearProgressIndicator(
        value: progress / 100.0, // Convert progress to a value between 0 and 1
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}
