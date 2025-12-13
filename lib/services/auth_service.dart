import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String _userKey = 'currentUser';
  static const String _tokenKey = 'authToken';

  // Simulate login - In a real app, this would make an API call
  Future<bool> login(String email, String password, {bool isUser = true}) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any non-empty credentials
    if (email.isNotEmpty && password.isNotEmpty) {
      final user = User(
        id: 1,
        username: 'demo_user',
        email: email,
        fullName: 'Demo User',
        phone: '081234567890',
        role: isUser ? 'user' : 'admin',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _saveUser(user, 'fake-jwt-token');
      return true;
    }
    
    return false;
  }

  // Simulate registration - In a real app, this would make an API call
  Future<bool> register(String username, String email, String phone, String password, {bool isUser = true}) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any non-empty credentials
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      final user = User(
        id: 2,
        username: username,
        email: email,
        fullName: username,
        phone: phone,
        role: isUser ? 'user' : 'admin',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _saveUser(user, 'fake-jwt-token');
      return true;
    }
    
    return false;
  }

  // Save user data and token to local storage
  Future<void> _saveUser(User user, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setString(_tokenKey, token);
  }

  // Get current user from local storage
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    
    if (userData != null) {
      final userJson = jsonDecode(userData);
      return User.fromJson(userJson);
    }
    
    return null;
  }

  // Get auth token from local storage
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
  }
}