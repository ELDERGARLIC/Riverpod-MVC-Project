import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_mvc_project/controllers/users_controller.dart';
import 'package:riverpod_mvc_project/models/user.dart';

// A service that fetchs the needed data from the API.
class ApiService {
  static const baseUrl = 'https://reqres.in/api';

  // A method that logs in and retrieves the token from the API.
  static Future<String> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'username': username, 'password': password},
    );

    final jsonResponse = jsonDecode(response.body);

    // Basic error handling in the login process.
    if (response.statusCode == 200) {
      // Successful login
      return jsonResponse['token'];
    } else {
      // Failed to login
      throw Exception('Failed to login');
    }
  }

  // A method that fetchs the participants from the API.
  static Future<dynamic> getParticipants(WidgetRef ref) async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    // Basic error handling in the fetching participants process.
    if (response.statusCode == 200) {
      final participantsList = jsonDecode(response.body)['data'];

      // Add the participants to the list of users.
      // This is done to be able to use the list of users in the UI.
      // Notifying the provider will rebuild the dependents.
      for (var participant in participantsList) {
        ref.read(userListProvider.notifier).add(
              User(
                id: participant['id'].toString(),
                email: participant['email'],
                firstName: participant['first_name'],
                lastName: participant['last_name'],
                avatarUrl: participant['avatar'],
              ),
            );
      }

      return participantsList;
    } else {
      // Failed to load participants
      throw Exception('Failed to load participants');
    }
  }
}
