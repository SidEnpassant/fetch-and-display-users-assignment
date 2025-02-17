import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String _error = '';
  String _searchQuery = '';

  List<User> get users => _users
      .where((user) =>
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _users = data.map((json) => User.fromJson(json)).toList();
      } else {
        _error = 'Failed to fetch users';
      }
    } catch (e) {
      _error = 'No internet connection';
    }

    _isLoading = false;
    notifyListeners();
  }

  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
