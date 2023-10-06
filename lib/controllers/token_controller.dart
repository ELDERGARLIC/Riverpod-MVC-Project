import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A provider that fetchs the token.
// It uses shared_preferences to retrieve the stored value of the token.
final tokenProvider = FutureProvider<String?>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
});
