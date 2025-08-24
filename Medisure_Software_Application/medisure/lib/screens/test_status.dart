import 'package:flutter/material.dart';
import 'package:medisure/main.dart';
import 'package:medisure/past_records_page.dart';

import 'package:flutter/material.dart';

class TestStatusApp extends StatefulWidget {
  @override
  _TestStatusAppState createState() => _TestStatusAppState();
}

class _TestStatusAppState extends State<TestStatusApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: TestStatusHomePage(
        isDarkMode: _isDarkMode,
        onDarkModeToggle: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

class TestStatusHomePage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeToggle;

  TestStatusHomePage(
      {required this.isDarkMode, required this.onDarkModeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            UserProfileSection(),
            SizedBox(height: 20),
            RefreshInfoSection(),
            SizedBox(height: 20),
            DarkModeSwitch(isDarkMode: isDarkMode, onToggle: onDarkModeToggle),
            SizedBox(height: 20),
            Expanded(child: PastRecordsList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('assets/profile.jpg'),
        ),
        SizedBox(width: 16),
        Text(
          'Ankit Sarkar, 20',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RefreshInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Blood Records will Refresh in',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 10),
        Text(
          '47 Hours 58 Minutes',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class DarkModeSwitch extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggle;

  DarkModeSwitch({required this.isDarkMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Switch to Dark Mode'),
        Switch(
          value: isDarkMode,
          onChanged: onToggle,
        ),
      ],
    );
  }
}

class PastRecordsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('1 Week Ago'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        );
      },
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
      ],
    );
  }
}
