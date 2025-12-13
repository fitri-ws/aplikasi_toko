import 'package:flutter/material.dart';
import 'package:aplikasi_toko/services/auth_service.dart';
import 'package:aplikasi_toko/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _authService.getCurrentUser();
    if (mounted) {
      setState(() {
        _user = user;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(child: Text("Tidak ada data pengguna"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile picture placeholder
                      Center(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade100,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // User info
                      _buildInfoTile("Nama Lengkap", _user!.fullName),
                      _buildInfoTile("Username", _user!.username),
                      _buildInfoTile("Email", _user!.email),
                      _buildInfoTile("Telepon", _user!.phone ?? "Belum diatur"),
                      _buildInfoTile("Peran", _user!.role == 'admin' ? "Admin" : "Pengguna"),
                      
                      const SizedBox(height: 30),
                      
                      // Role badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _user!.role == 'admin' 
                              ? Colors.red.shade100 
                              : Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _user!.role == 'admin' 
                                ? Colors.red 
                                : Colors.blue,
                          ),
                        ),
                        child: Text(
                          _user!.role == 'admin' ? "Admin" : "Pengguna",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _user!.role == 'admin' 
                                ? Colors.red 
                                : Colors.blue,
                          ),
                        ),
                      ),
                      
                      const Spacer(),
                      
                      // Logout button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _authService.logout();
                            if (mounted) {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              Navigator.pushReplacementNamed(context, '/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Keluar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? "Belum diatur" : value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}