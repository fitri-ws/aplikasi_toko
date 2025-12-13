import 'package:flutter/material.dart';
import 'dart:async';
import 'package:aplikasi_toko/screens/login_user.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();

    // Menunggu 3 detik sebelum pindah ke halaman login
    Timer(const Duration(seconds: 3), () {
      // Navigator.pushReplacement = pindahkan halaman dan hapus halaman sebelumnya
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginUser()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna background putih
      // Tampilan dibuat di tengah layar
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Posisi berada di tengah vertikal
          children: [
            // Container untuk logo
            Container(
              width: 120, // Lebar logo
              height: 120, // Tinggi logo
              decoration: BoxDecoration(
                color: Colors.blue, // Warna background logo
                borderRadius: BorderRadius.circular(20), // Sudut membulat
              ),

              // Icon HP di tengah
              child: const Icon(
                Icons.phone_android,
                color: Colors.white,
                size: 70,
              ),
            ),

            const SizedBox(height: 20), // Jarak antara logo dan teks
            // Teks utama judul aplikasi
            const Text(
              'PhoneStation',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Teks subjudul / slogan
            const Text(
              'Solusi Gadget Anda',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}