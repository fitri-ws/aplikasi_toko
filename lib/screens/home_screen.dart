import 'package:flutter/material.dart';
import 'package:aplikasi_toko/services/auth_service.dart';
import 'package:aplikasi_toko/services/smartphone_service.dart';
import 'package:aplikasi_toko/models/smartphone.dart';
import 'package:aplikasi_toko/screens/smartphone_detail.dart';
import 'package:aplikasi_toko/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  final SmartphoneService _smartphoneService = SmartphoneService();
  List<Smartphone> _smartphones = [];
  List<Smartphone> _filteredSmartphones = [];
  String _searchQuery = '';
  bool _isLoading = true;
  String _userName = 'Pengguna';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      setState(() {
        _userName = user.fullName;
      });
    }

    final smartphones = await _smartphoneService.getSmartphones();
    setState(() {
      _smartphones = smartphones;
      _filteredSmartphones = smartphones;
      _isLoading = false;
    });
  }

  void _filterSmartphones(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredSmartphones = _smartphones;
      } else {
        _filteredSmartphones = _smartphones
            .where((smartphone) =>
                smartphone.name.toLowerCase().contains(query.toLowerCase()) ||
                smartphone.brand.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PhoneStation"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Keluar'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Welcome banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Halo, $_userName!",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Temukan smartphone impianmu di sini",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari smartphone...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: _filterSmartphones,
            ),
          ),

          // Smartphones list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredSmartphones.isEmpty
                    ? const Center(
                        child: Text("Tidak ada smartphone ditemukan"),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredSmartphones.length,
                        itemBuilder: (context, index) {
                          final smartphone = _filteredSmartphones[index];
                          return _buildSmartphoneCard(smartphone);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmartphoneCard(Smartphone smartphone) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            smartphone.imageUrl ?? 'https://placehold.co/100x100?text=No+Image',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: const Icon(Icons.phone_android, size: 40),
              );
            },
          ),
        ),
        title: Text(
          smartphone.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              smartphone.brand,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Rp ${smartphone.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{3})$'), (Match m) => '${m[1]}').replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '.${m[1]}')}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SmartphoneDetailScreen(smartphone: smartphone),
            ),
          );
        },
      ),
    );
  }
}