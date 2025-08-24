import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool _isLoggedIn = false;
  String _username = "";
  DateTime? _installTime;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _getInstallTime();
  }

  void _checkLoginStatus() {
    // In-memory check (for demonstration)
    setState(() {
      _isLoggedIn = _isLoggedIn;
      _username = _username;
    });
  }

  void _getInstallTime() {
    // In-memory check (for demonstration)
    if (_installTime == null) {
      final now = DateTime.now();
      setState(() {
        _installTime = now;
      });
    }
  }

  void _login() {
    setState(() {
      _isLoggedIn = true;
      _username = 'testuser';
    });
  }

  void _resetInstallTime() {
    final now = DateTime.now();
    setState(() {
      _installTime = now;
    });
  }

  String _getUsageTime() {
    if (_installTime == null) return "Unknown";
    final duration = DateTime.now().difference(_installTime!);
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    return "${days}d ${hours}h ${minutes}m";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isLoggedIn ? "Logged In" : "Not Logged In"),
            if (_isLoggedIn) Text("Username: $_username"),
            if (_isLoggedIn) Text("Usage Time: ${_getUsageTime()}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoggedIn ? null : _login,
              child: const Text("Login"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetInstallTime,
              child: const Text("Reset Install Time"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: StatusPage(),
  ));
}
