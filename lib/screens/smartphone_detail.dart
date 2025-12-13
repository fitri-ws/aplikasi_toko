import 'package:flutter/material.dart';
import 'package:aplikasi_toko/models/smartphone.dart';

class SmartphoneDetailScreen extends StatelessWidget {
  final Smartphone smartphone;

  const SmartphoneDetailScreen({super.key, required this.smartphone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(smartphone.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Smartphone image
            SizedBox(
              height: 250,
              child: Image.network(
                smartphone.imageUrl ?? 'https://placehold.co/300x300?text=No+Image',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.phone_android, size: 80),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and name
                  Text(
                    smartphone.brand,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    smartphone.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Price
                  Text(
                    "Rp ${smartphone.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{3})$'), (Match m) => '${m[1]}').replaceAllMapped(RegExp(r'(\d{3})(?=\d)'), (Match m) => '.${m[1]}')}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Quick specs
                  const Text(
                    "Spesifikasi Singkat",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildSpecRow("Processor", smartphone.processor ?? "Tidak tersedia"),
                  _buildSpecRow("RAM", "${smartphone.ram} GB" ?? "Tidak tersedia"),
                  _buildSpecRow("Memori", "${smartphone.memory} GB" ?? "Tidak tersedia"),
                  _buildSpecRow("Layar", "${smartphone.screenSize}\"" ?? "Tidak tersedia"),
                  
                  const SizedBox(height: 20),
                  
                  // Scores
                  const Text(
                    "Nilai Performa",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildScoreRow("Performa", smartphone.performanceScore),
                  _buildScoreRow("Kamera", smartphone.cameraScore),
                  _buildScoreRow("Konektivitas", smartphone.connectivityScore),
                  _buildScoreRow("Baterai", smartphone.batteryScore),
                  
                  const SizedBox(height: 20),
                  
                  // Description
                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    smartphone.description ?? "Deskripsi tidak tersedia",
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Specifications
                  const Text(
                    "Spesifikasi Lengkap",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    smartphone.specifications ?? "Spesifikasi tidak tersedia",
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Stock info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: smartphone.stock! > 5 ? Colors.green.shade50 : Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: smartphone.stock! > 5 ? Colors.green : Colors.orange,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          smartphone.stock! > 5 ? Icons.check_circle : Icons.warning,
                          color: smartphone.stock! > 5 ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          smartphone.stock! > 5 
                            ? "Stok Tersedia (${smartphone.stock} unit)" 
                            : "Stok Terbatas (${smartphone.stock} unit)",
                          style: TextStyle(
                            color: smartphone.stock! > 5 ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Purchase button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // In a real app, this would open the purchase flow
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Beli Sekarang"),
                            content: Text("Apakah Anda ingin membeli ${smartphone.name}?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // In real app, would navigate to checkout
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Produk telah ditambahkan ke keranjang"),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text("Beli"),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Beli Sekarang",
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
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, double? score) {
    if (score == null) {
      return Container();
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  score.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: score / 10,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}