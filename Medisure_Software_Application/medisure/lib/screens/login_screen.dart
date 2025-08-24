import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medisure/levels.dart';
import 'package:medisure/signup.dart';
import 'package:medisure/uihelper.dart';
import 'package:medisure/globals.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  login(String email, String password) async {
    if (email == "" && password == "") {
      return UiHelper.CustomAlertBox(context, "Enter required fields");
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        global.user_id = email;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Levels()),
        );
      } on FirebaseAuthException {
        return UiHelper.CustomAlertBox(
          context,
          'Username or password is not correct',
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.CustomTextField(emailController, 'Email', Icons.mail, false),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ForgotPasswordPage()),
              ),
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          UiHelper.CustomButton(
            () => login(
              emailController.text.trim(),
              passwordController.text.trim(),
            ),
            'Login',
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('New User', style: TextStyle(fontSize: 20)),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const Signup()),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
