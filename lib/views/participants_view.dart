import 'package:flutter/material.dart';
import 'package:riverpod_mvc_project/controllers/users_controller.dart';
import 'package:riverpod_mvc_project/services/api_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_mvc_project/widgets/participant_tile.dart';

class ParticipantsView extends HookConsumerWidget {
  const ParticipantsView({Key? key}) : super(key: key);
  // Define a route name for this view.
  static const routeName = '/participants';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Participants',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      // Use FutureBuilder to fetch the participants from the API.
      // This is done to be able to use the list of users in the UI.
      // Notifying the provider will rebuild the dependents.
      body: FutureBuilder(
        future: ApiService.getParticipants(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error, for example:
            return Text('Error: ${snapshot.error}');
          } else {
            // Get the list of users from the provider
            // This is done to be able to use the list of users in the UI.
            final users = ref.watch(userListProvider);

            // Build the list of users
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ParticipantTile(user: users[index]);
              },
            );
          }
        },
      ),
    );
  }
}
