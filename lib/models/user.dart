import 'package:flutter/foundation.dart' show immutable;

/// A read-only description of a user
/// Model class for User which is used in the project.
@immutable
class User {
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  @override
  String toString() {
    return 'User(email: $email, last name: $lastName)';
  }
}
