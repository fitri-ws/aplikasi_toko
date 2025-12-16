# 📱 Aplikasi Toko HP - PhoneStation

Aplikasi mobile Flutter untuk toko smartphone dengan backend Node.js dan database MySQL. Aplikasi ini memungkinkan pengguna untuk melihat katalog smartphone dengan detail lengkap, rekomendasi, dan filter berdasarkan brand.

## ✨ Fitur Utama

### Untuk User:
- 🔐 **Login & Register** - Sistem autentikasi pengguna
- 📱 **Katalog Smartphone** - Lihat semua smartphone dengan detail lengkap
- ⭐ **Rekomendasi** - Smartphone terbaik berdasarkan overall score
- 🔍 **Pencarian** - Cari smartphone berdasarkan nama, brand, atau processor
- 🏷️ **Filter Brand** - Filter smartphone berdasarkan brand
- 📊 **Detail Lengkap** - Informasi spesifikasi, skor performa, harga, dan stok
- 🎨 **UI Modern** - Desain menarik dengan Google Fonts, gradients, dan animasi

### Untuk Admin:
- 📊 **Dashboard** - Statistik penjualan dan manajemen
- ➕ **Tambah Produk** - Menambah smartphone baru
- ✏️ **Edit Produk** - Mengubah informasi smartphone
- 🗑️ **Hapus Produk** - Menghapus smartphone dari katalog

## 🛠️ Teknologi yang Digunakan

### Frontend (Flutter):
- Flutter SDK 3.9.2+
- Dart
- Google Fonts
- Cached Network Image
- Flutter Rating Bar
- HTTP package

### Backend (Node.js):
- Express.js
- MySQL2
- JWT (JSON Web Tokens)
- Bcrypt.js
- CORS
- Dotenv

### Database:
- MySQL

## 📋 Prerequisites

Sebelum menjalankan aplikasi, pastikan Anda sudah menginstall:

1. **Flutter SDK** (versi 3.9.2 atau lebih baru)
   - Download dari: https://flutter.dev/docs/get-started/install
   - Tambahkan Flutter ke PATH

2. **Node.js** (versi 16 atau lebih baru)
   - Download dari: https://nodejs.org/

3. **MySQL** (versi 8.0 atau lebih baru)
   - Download dari: https://dev.mysql.com/downloads/mysql/
   - Atau gunakan XAMPP/WAMP

4. **Android Studio** atau **VS Code** dengan Flutter extension

5. **Emulator Android** atau **Device Fisik**

## 🚀 Cara Instalasi dan Menjalankan

### 1. Setup Database

1. Buka MySQL (melalui XAMPP, WAMP, atau MySQL Workbench)

2. Import database:
   ```sql
   -- Buka file database.sql dan jalankan di MySQL
   ```
   
   Atau jalankan command:
   ```bash
   mysql -u root -p < database.sql
   ```

3. Database `smartphone_store` akan otomatis dibuat dengan semua tabel dan data sample

### 2. Setup Backend (Node.js)

1. Buka terminal dan masuk ke folder backend:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Konfigurasi file `.env` (sudah ada, tapi pastikan sesuai dengan setup MySQL Anda):
   ```env
   PORT=5000
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=
   DB_NAME=smartphone_store
   JWT_SECRET=your_jwt_secret_key_change_this_in_production
   ```

4. Jalankan server:
   ```bash
   npm start
   ```
   
   Atau untuk development dengan auto-reload:
   ```bash
   npm run dev
   ```

5. Server akan berjalan di `http://localhost:5000`

### 3. Setup Flutter App

1. Buka terminal baru dan masuk ke root folder project

2. Install dependencies Flutter:
   ```bash
   flutter pub get
   ```

3. **PENTING**: Konfigurasi Base URL di `lib/services/smartphone_service.dart`:
   
   - Untuk **Android Emulator**:
     ```dart
     static const String baseUrl = 'http://10.0.2.2:5000/api';
     ```
   
   - Untuk **iOS Simulator**:
     ```dart
     static const String baseUrl = 'http://localhost:5000/api';
     ```
   
   - Untuk **Device Fisik** (ganti dengan IP komputer Anda):
     ```dart
     static const String baseUrl = 'http://192.168.1.XXX:5000/api';
     ```
     
     Cara cek IP komputer:
     - Windows: `ipconfig` di CMD
     - Mac/Linux: `ifconfig` di Terminal

4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## 👤 Akun Default

### User:
Anda bisa register akun baru melalui aplikasi

### Admin:
- **Username**: admin
- **Email**: admin@smartphonestore.com
- **Password**: admin123

## 📱 Cara Menggunakan Aplikasi

### Sebagai User:

1. **Register/Login**
   - Buka aplikasi
   - Pilih "Register" untuk membuat akun baru
   - Atau "Login" jika sudah punya akun

2. **Melihat Katalog**
   - Setelah login, Anda akan melihat home screen
   - Ada 2 tab: "⭐ Rekomendasi" dan "📱 Semua HP"
   - Tab Rekomendasi menampilkan smartphone terbaik berdasarkan score

3. **Mencari Smartphone**
   - Gunakan search bar di atas untuk mencari
   - Ketik nama smartphone, brand, atau processor

4. **Filter by Brand**
   - Scroll horizontal chips di bawah search bar
   - Pilih brand untuk filter (Xiaomi, Samsung, OPPO, dll)
   - Pilih "Semua" untuk menampilkan semua brand

5. **Melihat Detail**
   - Tap pada card smartphone
   - Lihat detail lengkap: spesifikasi, skor performa, harga, stok
   - Klik "Beli Sekarang" untuk membeli (fitur demo)

6. **Profile**
   - Tap icon profile di header
   - Lihat informasi akun Anda
   - Logout dari menu

## 🎨 Fitur UI/UX

1. **Modern Design**
   - Google Fonts (Poppins)
   - Gradient backgrounds
   - Smooth shadows
   - Rounded corners

2. **Responsive**
   - Grid layout untuk katalog
   - List layout untuk rekomendasi
   - Adaptive untuk berbagai ukuran layar

3. **Image Loading**
   - Cached network images
   - Placeholder saat loading
   - Error handling dengan icon fallback

4. **Interactive Elements**
   - Smooth animations
   - Ripple effects
   - Tab navigation
   - Filter chips

## 📊 Struktur Database

### Tables:
- **users** - Data pengguna (user & admin)
- **smartphones** - Data smartphone
- **orders** - Data pesanan
- **order_items** - Detail item pesanan
- **cart** - Keranjang belanja
- **reviews** - Review dan rating

## 🔧 Troubleshooting

### Backend tidak bisa connect ke MySQL:
- Pastikan MySQL service berjalan
- Cek username, password, dan database name di `.env`
- Pastikan database `smartphone_store` sudah dibuat

### Flutter tidak bisa connect ke backend:
- Pastikan backend server berjalan di port 5000
- Cek base URL di `smartphone_service.dart`
- Untuk device fisik, pastikan komputer dan device di network yang sama
- Disable firewall jika perlu

### Error saat flutter pub get:
- Pastikan Flutter SDK sudah terinstall dengan benar
- Jalankan `flutter doctor` untuk cek setup
- Coba hapus `pubspec.lock` dan jalankan lagi

### Gambar tidak muncul:
- Gambar menggunakan placeholder dari placehold.co
- Pastikan device/emulator terkoneksi internet
- Jika ingin gambar real, update `image_url` di database

## 📝 Catatan Penting

1. **Base URL**: Jangan lupa sesuaikan base URL di `smartphone_service.dart` sesuai dengan environment Anda

2. **CORS**: Backend sudah dikonfigurasi untuk menerima request dari semua origin. Untuk production, sebaiknya dibatasi.

3. **Security**: JWT secret di `.env` harus diganti untuk production

4. **Images**: Saat ini menggunakan placeholder. Untuk production, upload gambar real ke server atau cloud storage

5. **Database**: Data sample sudah include di `database.sql`. Anda bisa menambah/edit data melalui admin panel atau langsung di database

## 🎯 Tujuan Aplikasi

Aplikasi ini dibuat untuk memudahkan customer toko HP dalam:
- **Melihat katalog lengkap** tanpa harus mondar-mandir di toko
- **Mendapatkan rekomendasi** smartphone terbaik sesuai kebutuhan
- **Membandingkan spesifikasi** dengan mudah
- **Melihat detail lengkap** sebelum membeli
- **Menghemat waktu** dengan fitur search dan filter

## 📞 Support

Jika ada pertanyaan atau masalah, silakan:
1. Cek dokumentasi di `DOKUMENTASI.md`
2. Cek instalasi di `INSTALASI.md`
3. Review code untuk understanding lebih dalam

## 🚀 Future Improvements

- [ ] Implementasi cart dan checkout yang lengkap
- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Wishlist feature
- [ ] Product comparison
- [ ] User reviews and ratings
- [ ] Order tracking
- [ ] Admin dashboard yang lebih lengkap
- [ ] Real product images
- [ ] Multi-language support

---

**Dibuat dengan ❤️ menggunakan Flutter & Node.js**
