import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mvc_project/models/user.dart';

/// A provider that creates a list of [User].
final userListProvider = StateNotifierProvider<UserList, List<User>>((ref) {
  return UserList(const []);
});

/// An object that controls a list of [User].
class UserList extends StateNotifier<List<User>> {
  UserList([List<User>? initialUsers]) : super(initialUsers ?? []);

  // Method which adds a user to the list.
  void add(User user) {
    state = [
      ...state,
      user,
    ];
  }

  // Method which removes a user from the list.
  void remove(User target) {
    state = state.where((user) => user.id != target.id).toList();
  }

  // Method which removes all users in the list.
  void removeAll() {
    state = [];
  }
}
