import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/resources/auth_methods.dart';

class UserProvider with ChangeNotifier { // make a new class called UserProvider, that gets the user details and notifies listeners if the user is updated, 
  // So that the state of the app is globally managed.
  User? _user;
  final AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!; // no idea.

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails(); // gets user details
    _user = user;
    notifyListeners(); // notifies the children who are listening to the provider.
  }
}
