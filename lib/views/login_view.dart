import 'package:flutter/material.dart';
import 'package:riverpod_mvc_project/services/api_service.dart';
import 'package:riverpod_mvc_project/views/participants_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  // Define a route name for this view.
  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Create two text controllers. One for the email field and another for the password field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;

                // Check if the email and password fields are not empty
                if (email.isNotEmpty && password.isNotEmpty) {
                  try {
                    String token = await ApiService.loginUser(email, password);

                    // Save the token to SharedPreferences
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('token', token);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ParticipantsView();
                        },
                      ),
                    );
                  } catch (e) {
                    // Handle login error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Failed to login. Please try again. $e')),
                    );
                  }
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter both username and password.'),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
