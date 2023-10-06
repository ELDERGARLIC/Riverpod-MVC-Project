/// This project is simple demo of Riverpod and MVC architecture.
/// it will use reqres.in API to fetch users and display them in a list.
/// it will also use shared_preferences to store the token.
/// Error handling is implemented in this project.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvc_project/controllers/token_controller.dart';
import 'package:riverpod_mvc_project/views/login_view.dart';
import 'package:riverpod_mvc_project/views/participants_view.dart';

void main() async {
  // Ensure that SharedPreferences is initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod MVC Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      // Define the routes
      routes: {
        LoginView.routeName: (context) => const LoginView(),
        ParticipantsView.routeName: (context) => const ParticipantsView(),
      },

      /// Consumer allows us reading providers.
      /// It will listen to providers, and rebuild dependents whenever the provider(s) updates.
      /// Currently, it is used to check if the user is logged in or not.
      /// Based on the tokenProvider
      home: Consumer(
        builder: (context, watch, child) {
          final tokenAsyncValue = watch.watch(tokenProvider);

          return tokenAsyncValue.when(
            data: (token) {
              return token != null
                  ? const ParticipantsView()
                  : const LoginView();
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) {
              // Handle error, for example:
              return Text('Error: $error');
            },
          );
        },
      ),
    );
  }
}
