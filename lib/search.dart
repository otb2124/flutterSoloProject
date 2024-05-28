import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300], // Light grey color
            borderRadius: BorderRadius.circular(
                20.0), // Adjust the border radius as needed
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Colors.grey[600]), // Dark grey hint text color
              prefixIcon: Icon(Icons.search,
                  color: Colors.grey[600]), // Dark grey search icon color
            ),
            style: TextStyle(color: Colors.grey[600]), // Dark grey text color
          ),
        ),
        elevation: 0, // Remove the appbar shadow
        backgroundColor: Colors.white, // White background color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recent',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Number of recent users
              itemBuilder: (context, index) {
                // Replace with your user data
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0.0), // Adjust the vertical padding
                  child: ListTile(
                    leading: Icon(Icons.person,
                        size: 40.0), // Set profile picture size
                    title: Text(
                      'User $index',
                      style: TextStyle(
                          fontWeight:
                              FontWeight.bold), // Set font weight for username
                    ), // Replace with username
                    subtitle: Text('user_$index'), // Replace with user tag

                    onTap: () {
                      // Handle user tap
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
