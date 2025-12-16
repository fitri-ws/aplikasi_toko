import 'package:flutter/material.dart';

// Halaman pendaftaran admin (simulasi tanpa database)
class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  // key untuk validasi form
  final _formKey = GlobalKey<FormState>();
  // controller untuk menangani input dari TextFormField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  // untuk menampilkan loading saat proses submit
  bool _isLoading = false;

  // Fungsi dipanggil saat tombol Daftar ditekan
  void _submitForm() {
    // cek validasi form
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Tampilan loading
      });
      // simulasi proses pendaftaran tanpa database (delay 2 detik)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false; // Sembunyikan loading
        });
        // Tampilkan dialog sukses
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Sukses"),
            content: const Text("Admin berhasil didaftarkan (simulasi)"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );

        // Reset semua field setelah submit
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _passwordController.clear();
        _confirmController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Admin"), // Judul halaman
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Jarak dari tepi layar
        child: Form(
          key: _formKey, // Assign form key
          child: ListView(
            children: [
              // Field input Nama Lengkap
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nama Lengkap",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Jarak antar field

              // Field input Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return "Email tidak valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field input No Telepon
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "No Telepon",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "No telepon tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field input Password
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true, // Sembunyikan teks
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                  if (value.length < 6) {
                    return "Password minimal 6 karakter";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Field input Konfirmasi Password
              TextFormField(
                controller: _confirmController,
                decoration: const InputDecoration(
                  labelText: "Konfirmasi Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Silakan konfirmasi password";
                  }
                  if (value != _passwordController.text) {
                    return "Password tidak cocok";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Tombol Daftar Admin
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm, // Disable saat loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white, // Loading indicator
                        )
                      : const Text(
                          "Daftar Admin",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ), // Teks tombol
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