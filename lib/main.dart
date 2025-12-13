import 'package:flutter/material.dart';
import 'screens/logo_screen.dart';
import 'screens/login_user.dart';
import 'screens/login_admin.dart';
import 'screens/register_user.dart';
import 'screens/register_admin.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi Flutter
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp = kerangka utama aplikasi
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan tulisan debug merah di pojok
      title: 'PhoneStation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Halaman pertma yang muncul
      home: const LogoScreen(),
      // semua halaman dimasukkan ke routes
      routes: {
        '/logo': (context) => const LogoScreen(),
        '/login': (context) => const LoginUser(),
        '/loginadmin': (context) => const LoginAdmin(),
        '/register': (context) => const RegisterUserPage(),
        '/registeradmin': (context) => const AdminRegisterPage(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
