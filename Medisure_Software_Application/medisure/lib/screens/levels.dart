import 'package:flutter/material.dart';
import 'package:medisure/firestore.dart';
import 'package:medisure/globals.dart';
import 'package:medisure/login_page.dart';
import 'package:medisure/profile_edit.dart';
import 'package:medisure/spo2_page.dart';
import 'package:medisure/past_records_page.dart';
//import 'package:medisure/spo2_page_windows.dart';
import 'package:medisure/usermodel.dart';

import 'glucose_page.dart';
import 'dart:io' show Platform;

class Levels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medisure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final FirestoreService firestoreService = FirestoreService();

class _HomePageState extends State<HomePage> {
  String userName = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      //debugPrint("found username");
      User user = await firestoreService.getUser(global.user_id);
      //debugPrint("found username1");
      if (user != null && user.name != null) {
        // debugPrint("found username2");
        setState(() {
          userName = user.name;
          //debugPrint("found username3");
        });
      } else {
        setState(() {
          userName = "Unknown User";
        });
      }
    } catch (e) {
      print('Error fetching user name: $e');
      setState(() {
        userName = "Unknown User";
      });
      //debugPrint("Exception");
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage())); // Navigate to login page
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello  $userName",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            HealthMetricCard(
              title: 'SPO2 Level',
              subtitle: 'Give us a call in order to schedule your appointment.',
              onTap: () {
                if (Platform.isAndroid) {
                  // Android-specific code
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Spo2Page()));
                } 
              },
              color: Colors.deepPurple,
            ),
            SizedBox(height: 20),
            HealthMetricCard(
              title: 'Blood Glucose Level',
              subtitle:
                  'Schedule an appointment with our licensed professionals.',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BloodGlucosePage()));
              },
              color: Colors.teal,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              _showLogoutConfirmationDialog(context);

              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PastRecordsPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }
}

class HealthMetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final MaterialColor color;

  HealthMetricCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
