import 'package:flutter/material.dart';

// Halaman Login menggunakan StatefulWidget agar bisa mengubah state seperti loading
class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  // Controller untuk mengambil inputan email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false; // untuk menampilkan loading ketika login ditekan

  // Fungsi login palsu (simulasi)
  void login() async {
    setState(() {
      isLoading = true; // tampilkan loading
    });

    await Future.delayed(const Duration(seconds: 1)); // simulasi prosess login

    setState(() {
      isLoading = false; // hilangkan loading
    });

    // Validasi sederhana, jika input tidak kosong → masuk ke Home
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
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
      backgroundColor: const Color.fromARGB(255, 244, 243, 242),

      // Semua isi halaman ditengah
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // =================== LOGO TOKO ====================
              Icon(Icons.storefront, size: 80, color: Colors.blue.shade700),
              const SizedBox(height: 20),

              // =================== JUDUL ====================
              const Text(
                "Login Akun",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // =================== INPUT EMAIL ====================
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // =================== INPUT PASSWORD ====================
              TextField(
                controller: passwordController,
                obscureText: true, // password disembunyikan
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                          "Login",
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
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text("Daftar"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
