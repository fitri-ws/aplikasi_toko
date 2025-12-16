# 🔧 Panduan Konfigurasi Base URL

## Mengapa Perlu Konfigurasi?

Flutter app perlu tahu di mana backend server berada. Lokasi server berbeda tergantung di mana Anda menjalankan aplikasi:
- Android Emulator
- iOS Simulator  
- Device Fisik (HP/Tablet)

## 📍 Lokasi File yang Perlu Diubah

File: `lib/services/smartphone_service.dart`

Cari baris ini (sekitar line 9):
```dart
static const String baseUrl = 'http://localhost:5000/api';
```

## 🎯 Pilih Konfigurasi Sesuai Environment

### 1️⃣ Untuk Android Emulator

```dart
static const String baseUrl = 'http://10.0.2.2:5000/api';
```

**Penjelasan**: `10.0.2.2` adalah IP khusus yang digunakan Android Emulator untuk mengakses `localhost` komputer host.

### 2️⃣ Untuk iOS Simulator

```dart
static const String baseUrl = 'http://localhost:5000/api';
```

**Penjelasan**: iOS Simulator bisa langsung menggunakan `localhost`.

### 3️⃣ Untuk Device Fisik (HP/Tablet Android/iOS)

```dart
static const String baseUrl = 'http://192.168.1.XXX:5000/api';
```

**Ganti `192.168.1.XXX` dengan IP address komputer Anda!**

## 🔍 Cara Cek IP Address Komputer

### Windows:
1. Buka Command Prompt (CMD)
2. Ketik: `ipconfig`
3. Cari "IPv4 Address" di bagian "Wireless LAN adapter Wi-Fi" atau "Ethernet adapter"
4. Contoh: `192.168.1.5`

### Mac:
1. Buka Terminal
2. Ketik: `ifconfig | grep "inet "`
3. Atau buka System Preferences > Network
4. Lihat IP Address

### Linux:
1. Buka Terminal
2. Ketik: `ifconfig` atau `ip addr show`
3. Cari IP address di interface yang aktif

## ⚠️ Penting untuk Device Fisik

1. **Komputer dan HP harus di network WiFi yang sama**
   - Contoh: Keduanya connect ke WiFi "Rumah"
   
2. **Firewall mungkin perlu dimatikan**
   - Windows: Settings > Windows Security > Firewall & network protection
   - Atau tambahkan exception untuk port 5000

3. **Pastikan backend server sudah running**
   ```bash
   cd backend
   npm start
   ```
   
   Harus muncul: `Server is running on port 5000`

## 🧪 Testing Koneksi

### Test 1: Dari Browser Komputer
Buka browser dan akses:
```
http://localhost:5000/api/health
```

Harus muncul:
```json
{"status":"OK","message":"Server is running"}
```

### Test 2: Dari Browser HP (untuk device fisik)
Ganti IP dengan IP komputer Anda:
```
http://192.168.1.XXX:5000/api/health
```

Jika berhasil, artinya koneksi OK!

### Test 3: Dari Flutter App
1. Jalankan app
2. Coba login atau lihat katalog
3. Jika muncul data smartphone, berarti berhasil!

## 🐛 Troubleshooting

### Error: "Failed to load smartphones"

**Penyebab 1**: Base URL salah
- ✅ Cek lagi base URL di `smartphone_service.dart`
- ✅ Pastikan sesuai dengan environment (emulator/simulator/device)

**Penyebab 2**: Backend tidak running
- ✅ Jalankan `npm start` di folder backend
- ✅ Cek di terminal apakah ada error

**Penyebab 3**: Firewall blocking (untuk device fisik)
- ✅ Matikan firewall sementara
- ✅ Atau tambahkan exception untuk port 5000

**Penyebab 4**: Beda network (untuk device fisik)
- ✅ Pastikan komputer dan HP di WiFi yang sama
- ✅ Jangan gunakan mobile data di HP

### Error: "Connection refused"

- Backend belum running
- Port 5000 sudah dipakai aplikasi lain
- IP address salah (untuk device fisik)

### Error: "Timeout"

- Network terlalu lambat
- Firewall blocking
- IP address tidak bisa diakses

## 📝 Checklist Sebelum Running

- [ ] MySQL service running
- [ ] Database `smartphone_store` sudah dibuat
- [ ] Backend server running (`npm start`)
- [ ] Base URL sudah dikonfigurasi dengan benar
- [ ] (Untuk device fisik) Komputer dan HP di network yang sama
- [ ] (Untuk device fisik) Firewall sudah di-handle
- [ ] Flutter dependencies sudah diinstall (`flutter pub get`)

## 💡 Tips

1. **Gunakan Android Emulator untuk development**
   - Lebih mudah setup
   - Tidak perlu konfigurasi network
   - Lebih cepat testing

2. **Gunakan device fisik untuk testing real**
   - Performance lebih akurat
   - Testing UX yang lebih real
   - Bisa test di berbagai device

3. **Simpan IP address komputer**
   - Jika sering ganti network, IP bisa berubah
   - Perlu update base URL lagi

## 🎯 Rekomendasi Workflow

1. **Development**: Gunakan Android Emulator
   ```dart
   static const String baseUrl = 'http://10.0.2.2:5000/api';
   ```

2. **Testing**: Gunakan device fisik
   ```dart
   static const String baseUrl = 'http://192.168.1.XXX:5000/api';
   ```

3. **Production**: Deploy backend ke server
   ```dart
   static const String baseUrl = 'https://your-domain.com/api';
   ```

---

**Jika masih ada masalah, cek:**
- Backend logs di terminal
- Flutter logs di debug console
- Network connectivity
