import 'package:flutter/material.dart';
import 'logo.dart'; // Mengimpor halaman LogoPage agar bisa dijadikan halaman pertama

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp = kerangka utama aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Menghilangkan tulisan debug merah di pojok
      // Halaman pertama yang ditampilkan saat aplikasi dibuka
      home: const Logo(), // Aplikasi masuk ke halaman logo terlebih dahulu
    );
  }
}
