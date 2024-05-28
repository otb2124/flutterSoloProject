import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myproject/post.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  String userName = 'Orest Brukhal';
  String userTag = 'otb2124';
  String description1 = 'Description 1';
  String description2 = 'Description 2';

  void _showAddTaskDialog(BuildContext context) {
    double progress = 0.0; // Initial progress value
    String deadline = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return FutureBuilder(
              future: _getCurrentDate(), // Get current date from API
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  deadline = snapshot.data as String;
                  return AlertDialog(
                    title: Text("Add Task"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Task Name'),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Task Description'),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Progress:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Slider(
                          value: progress,
                          onChanged: (newValue) {
                            setState(() {
                              progress = newValue;
                            });
                          },
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: progress.round().toString(),
                        ),
                        SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              onChanged: (date) {
                                print('change $date');
                              },
                              onConfirm: (date) {
                                deadline = date.toString();
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en,
                            );
                          },
                          child: Text(
                            'Deadline: $deadline',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Perform task addition here
                            Navigator.pop(context);
                          },
                          child: Text('Add'),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  Future<String> _getCurrentDate() async {
    final response =
        await http.get(Uri.parse('https://worldtimeapi.org/api/ip'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String currentDatetime = responseData['datetime'];
      DateTime datetime = DateTime.parse(currentDatetime);
      return datetime.toLocal().toString();
    } else {
      throw Exception('Failed to load current date');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfileSection(), // Build profile section
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                    child: Text(
                      isEditing ? 'Apply changes' : 'Edit Profile',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showSettingsDialog(context); // Show settings dialog
                    },
                    child: Text('Settings'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showAddTaskDialog(context);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero, // Remove horizontal padding
              itemCount: 5, // Number of tasks
              itemBuilder: (context, index) {
                return PostWidget(
                  profilePicture:
                      Icons.person, // Replace with your profile picture
                  name: userName, // Use username variable
                  userTag: userTag, // Use usertag variable
                  date: '21 May 2020',
                  description:
                      'My Progress on Task $index', // Replace with task description
                  progress:
                      50.0, // Example progress value, replace it with your actual data
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 80.0, // Increase profile picture size
            backgroundImage: AssetImage(
                'assets/profile_image.png'), // Replace with your image
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isEditing
                    ? TextFormField(
                        initialValue: userName,
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                      )
                    : Text(
                        userName,
                        style: TextStyle(
                            fontSize: 44.0, fontWeight: FontWeight.bold),
                      ),
                isEditing
                    ? SizedBox(height: 8.0)
                    : Text(
                        userTag,
                        style: TextStyle(fontSize: 22.0),
                      ),
                SizedBox(height: 8.0),
                isEditing
                    ? TextFormField(
                        initialValue: description1,
                        onChanged: (value) {
                          setState(() {
                            description1 = value;
                          });
                        },
                      )
                    : Text(
                        description1,
                        style: TextStyle(fontSize: 16.0),
                      ),
                isEditing
                    ? TextFormField(
                        initialValue: description2,
                        onChanged: (value) {
                          setState(() {
                            description2 = value;
                          });
                        },
                      )
                    : Text(
                        description2,
                        style: TextStyle(fontSize: 16.0),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Settings"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to Settings1 screen
                  Navigator.pop(context);
                },
                child: ListTile(
                  title: Text("Settings1"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to Sign In page
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: ListTile(
                  title: Text("Log Out"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
