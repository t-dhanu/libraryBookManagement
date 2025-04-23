import 'package:flutter/material.dart';
import 'package:testapp/models/custom_user.dart';
import 'package:testapp/models/custom_user.dart';  // Import CustomUser model

class HomePage extends StatelessWidget {
  final CustomUser user;  // Accept the CustomUser object

  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Text(
          "Welcome, ${user.username}!",  // Display the username of the user
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
