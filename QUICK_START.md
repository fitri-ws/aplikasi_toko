# 🚀 QUICK START GUIDE - Aplikasi Toko HP

Panduan cepat untuk menjalankan aplikasi dalam 5 menit!

## ⚡ Prerequisites

Pastikan sudah terinstall:
- ✅ Flutter SDK
- ✅ Node.js
- ✅ MySQL (XAMPP/WAMP/MySQL Workbench)
- ✅ Android Studio atau VS Code
- ✅ Android Emulator atau Device

## 🎯 Langkah Cepat

### 1️⃣ Setup Database (2 menit)

```bash
# Buka MySQL (via XAMPP/WAMP atau MySQL Workbench)
# Import database.sql
# Atau jalankan:
mysql -u root -p < database.sql
```

✅ Database `smartphone_store` akan otomatis dibuat dengan data sample

### 2️⃣ Start Backend (1 menit)

```bash
cd backend
npm install
npm start
```

✅ Server akan running di `http://localhost:5000`

### 3️⃣ Configure Flutter (30 detik)

Edit file: `lib/services/smartphone_service.dart`

**Untuk Android Emulator** (recommended untuk testing):
```dart
static const String baseUrl = 'http://10.0.2.2:5000/api';
```

**Untuk iOS Simulator**:
```dart
static const String baseUrl = 'http://localhost:5000/api';
```

**Untuk Device Fisik** (ganti dengan IP komputer):
```dart
static const String baseUrl = 'http://192.168.1.XXX:5000/api';
```

💡 Cara cek IP: Ketik `ipconfig` di CMD (Windows)

### 4️⃣ Run Flutter App (1 menit)

```bash
flutter pub get
flutter run
```

✅ App akan running di emulator/device

## 🎉 Done!

Aplikasi sudah berjalan! Sekarang Anda bisa:

1. **Register** akun baru atau **Login** dengan:
   - Email: `admin@smartphonestore.com`
   - Password: `admin123`

2. **Explore fitur**:
   - Tab Rekomendasi untuk HP terbaik
   - Tab Semua HP untuk katalog lengkap
   - Search bar untuk mencari
   - Filter brand untuk filter berdasarkan merek
   - Tap card untuk lihat detail

## 🔍 Quick Test

### Test Backend:
Buka browser: `http://localhost:5000/api/health`

Harus muncul:
```json
{"status":"OK","message":"Server is running"}
```

### Test Database:
```sql
USE smartphone_store;
SELECT COUNT(*) FROM smartphones;
-- Harus ada 15 smartphones
```

### Test Flutter:
- Login berhasil ✅
- Muncul list smartphones ✅
- Search berfungsi ✅
- Detail page muncul ✅

## ⚠️ Troubleshooting Cepat

### Backend tidak bisa connect ke MySQL?
```bash
# Cek MySQL running
# Cek .env file di folder backend
# Pastikan DB_PASSWORD sesuai (default kosong)
```

### Flutter tidak bisa connect ke backend?
```dart
// Cek base URL di smartphone_service.dart
// Untuk Android Emulator: http://10.0.2.2:5000/api
// Pastikan backend running
```

### Gambar tidak muncul?
```bash
# Pastikan internet connect
# Atau jalankan: mysql < update_images.sql
```

## 📚 Dokumentasi Lengkap

Untuk informasi lebih detail, baca:
- `README.md` - Dokumentasi lengkap
- `KONFIGURASI_URL.md` - Panduan konfigurasi URL
- `RINGKASAN_PERBAIKAN.md` - Detail semua perubahan

## 💡 Tips

1. **Gunakan Android Emulator** untuk development (lebih mudah)
2. **Matikan firewall** jika testing di device fisik
3. **Pastikan backend selalu running** sebelum buka app
4. **Cek terminal logs** jika ada error

## 🎯 Workflow Recommended

```bash
# Terminal 1: Backend
cd backend
npm start

# Terminal 2: Flutter
flutter run

# Browser: Test API
http://localhost:5000/api/health
```

## ✅ Checklist

- [ ] MySQL running
- [ ] Database imported
- [ ] Backend running (port 5000)
- [ ] Base URL configured
- [ ] Flutter dependencies installed
- [ ] App running on emulator/device
- [ ] Can login
- [ ] Can see smartphones
- [ ] Can search
- [ ] Can view details

---

**Selamat! Aplikasi sudah siap digunakan! 🎉**

Jika ada masalah, cek file dokumentasi lengkap atau review logs di terminal.
