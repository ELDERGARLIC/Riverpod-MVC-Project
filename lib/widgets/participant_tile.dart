import 'package:flutter/material.dart';
import 'package:riverpod_mvc_project/models/user.dart';

// A widget that displays the user information in a ListTile.
class ParticipantTile extends StatelessWidget {
  const ParticipantTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${user.firstName} ${user.lastName}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        user.email,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      leading: Image.network(
        user.avatarUrl,
      ),
      trailing: Text(user.id),
    );
  }
}
