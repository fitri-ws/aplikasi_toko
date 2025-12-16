import 'package:flutter/material.dart';
import 'package:aplikasi_toko/services/auth_service.dart';
import 'package:aplikasi_toko/screens/register_user.dart';
import 'package:aplikasi_toko/screens/home_screen.dart';

// Halaman Login menggunakan StatefulWidget agar bisa mengubah state seperti loading
class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginUser> {
  // Controller untuk mengambil inputan email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false; // untuk menampilkan loading ketika login ditekan

  // Fungsi login dengan auth service
  void login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        isLoading = true; // tampilkan loading
      });

      // Attempt to login
      bool success = await _authService.login(
        emailController.text,
        passwordController.text,
        isUser: true,
      );

      setState(() {
        isLoading = false; // hilangkan loading
      });

      if (success) {
        // Navigate to home screen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login gagal. Periksa kembali email dan password Anda.")),
        );
      }
    } else {
      // Jika input kosong → tampilkan snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password tidak boleh kosong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Semua isi halaman ditengah
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // =================== LOGO TOKO ====================
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.phone_android,
                  size: 80,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 20),

              // =================== JUDUL ====================
              const Text(
                "Selamat Datang",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Silakan masuk untuk melanjutkan",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              // =================== INPUT EMAIL ====================
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              // =================== INPUT PASSWORD ====================
              TextFormField(
                controller: passwordController,
                obscureText: true, // password disembunyikan
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 25),

              // =================== TOMBOL LOGIN ====================
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login, // nonaktif saat loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Animasi loading atau teks login
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Masuk",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // =================== LINK KE REGISTER ====================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Belum punya akun?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterUserPage()),
                      );
                    },
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Admin login link
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/loginadmin');
                },
                child: const Text(
                  "Masuk sebagai Admin",
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
