import 'package:flutter/material.dart';
import 'package:aplikasi_toko/services/auth_service.dart';
import 'package:aplikasi_toko/services/smartphone_service.dart';
import 'package:aplikasi_toko/models/smartphone.dart';
import 'package:aplikasi_toko/screens/smartphone_detail.dart';
import 'package:aplikasi_toko/screens/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final SmartphoneService _smartphoneService = SmartphoneService();
  List<Smartphone> _smartphones = [];
  List<Smartphone> _filteredSmartphones = [];
  List<Smartphone> _recommendedSmartphones = [];
  List<String> _brands = [];
  String _searchQuery = '';
  String? _selectedBrand;
  bool _isLoading = true;
  String _userName = 'Pengguna';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      setState(() {
        _userName = user.fullName;
      });
    }

    // Load data secara paralel
    final futures = await Future.wait([
      _smartphoneService.getSmartphones(),
      _smartphoneService.getRecommendedSmartphones(),
      _smartphoneService.getBrands(),
    ]);

    if (mounted) {
      setState(() {
        _smartphones = futures[0] as List<Smartphone>;
        _recommendedSmartphones = futures[1] as List<Smartphone>;
        _brands = futures[2] as List<String>;
        _filteredSmartphones = _smartphones;
        _isLoading = false;
      });
    }
  }

  void _filterSmartphones(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilter();
    });
  }

  void _filterByBrand(String? brand) {
    setState(() {
      if (_selectedBrand == brand) {
        _selectedBrand = null; // Toggle off
      } else {
        _selectedBrand = brand;
      }
      _applyFilter();
    });
  }

  void _applyFilter() {
    List<Smartphone> temp = _smartphones;

    // Filter by Brand
    if (_selectedBrand != null && _selectedBrand != 'Semua') {
      temp = temp.where((s) => s.brand == _selectedBrand).toList();
    }

    // Filter by Search
    if (_searchQuery.isNotEmpty) {
      temp = temp
          .where(
            (s) =>
                s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                s.brand.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    _filteredSmartphones = temp;
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
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildBrandFilter(),
            const SizedBox(height: 16),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildRecommendedTab(), _buildAllPhonesTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, $_userName! 👋',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              Text(
                'Temukan smartphone impianmu',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.person, color: Colors.blue.shade600),
            ),
          ),
          IconButton(
            onPressed: _logout,
            icon: CircleAvatar(
              backgroundColor: Colors.red.shade50,
              child: Icon(Icons.logout, color: Colors.red.shade600, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          onChanged: _filterSmartphones,
          decoration: InputDecoration(
            hintText: 'Cari smartphone...',
            hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.blue.shade600),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFilterChip('Semua', _selectedBrand == null),
          ..._brands
              .map((brand) => _buildFilterChip(brand, _selectedBrand == brand))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => _filterByBrand(label == 'Semua' ? null : label),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade600 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: Colors.grey.shade200),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              color: isSelected ? Colors.white : Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blue.shade600,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade600,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          tabs: const [
            Tab(text: "⭐ Rekomendasi"),
            Tab(text: "📱 Semua HP"),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_recommendedSmartphones.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mobile_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              "Tidak ada rekomendasi tersedia",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _recommendedSmartphones.length,
      itemBuilder: (context, index) {
        final phone = _recommendedSmartphones[index];
        return _buildRecommendedCard(phone, index + 1);
      },
    );
  }

  Widget _buildAllPhonesTab() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredSmartphones.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              "Smartphone tidak ditemukan",
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredSmartphones.length,
      itemBuilder: (context, index) {
        return _buildGridCard(_filteredSmartphones[index]);
      },
    );
  }

  Widget _buildRecommendedCard(Smartphone phone, int rank) {
    Color badgeColor = Colors.grey;
    if (rank == 1) badgeColor = Colors.amber;
    if (rank == 2) badgeColor = Colors.blueGrey;
    if (rank == 3) badgeColor = Colors.brown;

    double overallScore =
        ((phone.performanceScore ?? 0) +
            (phone.cameraScore ?? 0) +
            (phone.connectivityScore ?? 0) +
            (phone.batteryScore ?? 0)) /
        4;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SmartphoneDetailScreen(smartphone: phone),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Rank Badge
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "#$rank",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: badgeColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildImage(phone.imageUrl, width: 80, height: 80),
                ),
                const SizedBox(width: 16),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phone.brand,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.blue.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        phone.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            overallScore.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatPrice(phone.price),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.green.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade300),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(Smartphone phone) {
    double overallScore =
        ((phone.performanceScore ?? 0) +
            (phone.cameraScore ?? 0) +
            (phone.connectivityScore ?? 0) +
            (phone.batteryScore ?? 0)) /
        4;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SmartphoneDetailScreen(smartphone: phone),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImage(
                        phone.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  phone.brand,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  phone.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      overallScore.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _formatPrice(phone.price),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.green.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper untuk menampilkan gambar yang support assets
  Widget _buildImage(
    String? imageUrl, {
    required double width,
    required double height,
  }) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey.shade100,
        child: Icon(Icons.phone_android, color: Colors.grey.shade300),
      );
    }

    if (imageUrl.startsWith('assets/')) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.contain, // Contain agar gambar tidak terpotong
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, color: Colors.grey.shade300),
                Text(
                  "Asset Error",
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                ),
              ],
            ),
          );
        },
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey.shade100,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade100,
        child: Icon(Icons.error_outline, color: Colors.grey.shade300),
      ),
    );
  }

  String _formatPrice(double price) {
    var str = price.toStringAsFixed(0);
    var result = '';
    int c = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      result = str[i] + result;
      c++;
      if (c == 3 && i > 0) {
        result = '.' + result;
        c = 0;
      }
    }
    return 'Rp $result';
  }
}
