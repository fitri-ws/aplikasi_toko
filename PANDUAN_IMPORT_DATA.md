# 🚀 PANDUAN LENGKAP - Import Data CSV & Jalankan Aplikasi

## ⚠️ PENTING - Baca Ini Dulu!

Aplikasi sudah running tapi tidak ada data karena:
1. Database masih kosong atau menggunakan data lama
2. Gambar menggunakan placeholder, bukan foto asli dari folder `assets`

## 📋 Langkah-Langkah Perbaikan

### Step 1: Stop Aplikasi Flutter yang Sedang Running

Tekan `Ctrl+C` di terminal yang menjalankan `flutter run`

### Step 2: Import Data Baru ke Database

1. **Buka MySQL** (via XAMPP, WAMP, atau MySQL Workbench)

2. **Jalankan script** `import_csv_data.sql`:
   ```bash
   mysql -u root -p smartphone_store < import_csv_data.sql
   ```
   
   Atau buka file `import_csv_data.sql` dan jalankan di MySQL Workbench/phpMyAdmin

3. **Verifikasi data berhasil diimport**:
   ```sql
   USE smartphone_store;
   SELECT COUNT(*) FROM smartphones;
   -- Harus ada 20 smartphones
   
   SELECT name, brand, image_url FROM smartphones LIMIT 5;
   -- Cek apakah image_url dimulai dengan 'assets/'
   ```

### Step 3: Pastikan Assets Sudah Dikonfigurasi

File `pubspec.yaml` sudah diupdate dengan:
```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/
```

### Step 4: Run Flutter Pub Get

```bash
flutter pub get
```

### Step 5: Jalankan Aplikasi

```bash
flutter run -d chrome
```

Atau pilih device lain (Android emulator, Windows, dll)

---

## 📱 Data Smartphone yang Diimport

Script `import_csv_data.sql` mengimport **20 smartphone** dari file CSV dengan detail lengkap:

### Daftar Smartphone:
1. **Alcatel 1S** - Rp 1.599.000 (3GB/32GB)
2. **Alcatel 1SE** - Rp 1.599.000 (4GB/64GB)
3. **ASUS Zenfone 4 Max** - Rp 1.699.000 (3GB/32GB)
4. **Infinix Hot 10 Play** - Rp 1.259.000 (2GB/32GB)
5. **Nokia C3** - Rp 1.499.000 (2GB/16GB)
6. **OPPO A11** - Rp 1.399.000 (2GB/32GB)
7. **OPPO A15** - Rp 1.799.000 (3GB/32GB)
8. **OPPO A11K** - Rp 1.699.000 (2GB/32GB)
9. **POCO M3** - Rp 1.799.000 (4GB/64GB) ⭐ Top Rated
10. **Realme C20** - Rp 1.249.000 (2GB/32GB)
11. **Realme C11** - Rp 1.429.000 (2GB/32GB)
12. **Realme C21** - Rp 1.700.000 (3GB/32GB)
13. **Samsung Galaxy A02s** - Rp 1.999.000 (4GB/64GB)
14. **Sharp Aquos V** - Rp 1.874.000 (4GB/64GB)
15. **Vivo Y20** - Rp 1.900.000 (3GB/64GB)
16. **Vivo Y12S** - Rp 1.899.000 (3GB/32GB)
17. **Vivo Y91C** - Rp 1.599.000 (2GB/32GB)
18. **Xiaomi Redmi 9A** - Rp 1.209.000 (2GB/32GB) 💰 Termurah
19. **Xiaomi Redmi 9C** - Rp 1.550.000 (3GB/32GB)
20. **Xiaomi Redmi 9T** - Rp 2.000.000 (4GB/64GB) ⭐ Best Value

### Setiap smartphone memiliki:
- ✅ Nama & Brand
- ✅ Harga (Rp 1.2jt - 2jt)
- ✅ Spesifikasi lengkap (Processor, RAM, Storage, Screen Size)
- ✅ Performance Scores (Performance, Camera, Connectivity, Battery)
- ✅ Deskripsi detail
- ✅ Spesifikasi lengkap
- ✅ Link Tokopedia
- ✅ **Foto asli dari folder assets**
- ✅ Stock information

---

## 🖼️ Foto Smartphone

Semua foto sudah tersedia di folder `assets/`:

```
assets/
├── alcatel_1S.jpg
├── Alcatel 1SE.jpg
├── Zenfone 4 Max.webp
├── Infinix Hot 10 Play.jpg
├── Nokia C3.png
├── Oppo A11.jpg
├── Oppo A11K.jpg
├── Oppo A15.jpg
├── Poco M3.jpg
├── Realme C11.jpg
├── Realme C20.jpg
├── Realme C21.jpg
├── Redmi 9A.jpg
├── Redmi 9C.jpg
├── Redmi 9T.jpg
├── Samsung Galaxy.jpg
├── Sharp Aquos V.jpg
├── Vivo Y12S.png
├── Vivo Y20.jpg
└── Vivo Y91C.png
```

**Total: 20 foto** untuk 20 smartphone

---

## 🎯 Fitur Rekomendasi

Aplikasi akan menampilkan **Top 10 Recommended Smartphones** berdasarkan:
- Overall Score = (Performance + Camera + Connectivity + Battery) / 4
- Sorted by score (DESC) dan price (ASC)
- Hanya smartphone dengan stock > 0

### Top 3 Recommended (berdasarkan score):
1. 🥇 **Xiaomi Redmi 9T** - Score: 7.5/10
2. 🥈 **POCO M3** - Score: 7.4/10
3. 🥉 **Xiaomi Redmi 9A** - Score: 7.2/10

---

## ✅ Checklist Sebelum Running

- [ ] MySQL running
- [ ] Database `smartphone_store` exists
- [ ] Script `import_csv_data.sql` sudah dijalankan
- [ ] Verifikasi ada 20 smartphones di database
- [ ] Backend running (`npm start` di folder backend)
- [ ] `pubspec.yaml` sudah include assets
- [ ] `flutter pub get` sudah dijalankan
- [ ] Base URL sudah dikonfigurasi di `smartphone_service.dart`

---

## 🐛 Troubleshooting

### Masalah: "Tidak ada rekomendasi tersedia"
**Solusi**: 
- Pastikan database sudah diimport dengan `import_csv_data.sql`
- Cek apakah ada data: `SELECT COUNT(*) FROM smartphones;`
- Pastikan backend running

### Masalah: Gambar tidak muncul
**Solusi**:
- Pastikan folder `assets` ada dan berisi foto-foto HP
- Pastikan `pubspec.yaml` sudah include `assets/`
- Jalankan `flutter pub get`
- Restart aplikasi

### Masalah: "Failed to load smartphones"
**Solusi**:
- Pastikan backend running di port 5000
- Cek base URL di `smartphone_service.dart`
- Untuk Chrome: `http://localhost:5000/api`
- Untuk Android Emulator: `http://10.0.2.2:5000/api`

---

## 📊 Cara Verifikasi Data

### 1. Cek Database
```sql
USE smartphone_store;

-- Cek jumlah smartphones
SELECT COUNT(*) as total FROM smartphones;

-- Cek 5 smartphone pertama
SELECT id, name, brand, price, stock, image_url 
FROM smartphones 
ORDER BY brand, name 
LIMIT 5;

-- Cek top recommended
SELECT name, brand, price,
       (performance_score + camera_score + connectivity_score + battery_score) / 4 as overall_score
FROM smartphones
WHERE stock > 0
ORDER BY overall_score DESC, price ASC
LIMIT 10;
```

### 2. Cek Backend API
Buka browser: `http://localhost:5000/api/smartphones`

Harus muncul JSON dengan 20 smartphones.

### 3. Cek Recommended API
Buka browser: `http://localhost:5000/api/smartphones/recommended`

Harus muncul JSON dengan top 10 smartphones.

---

## 🎨 Tampilan yang Diharapkan

### Home Screen:
- **Header**: "Halo, [Nama]! 👋" dengan gradient blue
- **Search Bar**: White dengan shadow
- **Brand Filter**: Chips horizontal (Alcatel, ASUS, Infinix, Nokia, OPPO, POCO, Realme, Samsung, Sharp, Vivo, Xiaomi)
- **Tab Bar**: "⭐ Rekomendasi" dan "📱 Semua HP"

### Tab Rekomendasi:
- List view dengan ranking badges (#1, #2, #3, dll)
- Foto HP dari assets
- Brand, nama, score, RAM/Storage, harga
- Gold badge untuk #1, Silver untuk #2, Bronze untuk #3

### Tab Semua HP:
- Grid view 2 kolom
- Foto HP dari assets
- Brand, nama, star rating, harga
- Compact card design

### Detail Screen:
- Large hero image (350px)
- Star rating bar
- Quick specs cards (2x2 grid)
- Performance score bars
- Description & specifications
- Stock information
- Buy button

---

## 💡 Tips

1. **Gunakan Chrome** untuk testing pertama kali (lebih mudah debug)
2. **Cek console logs** jika ada error
3. **Restart backend** jika ada perubahan di database
4. **Hot reload** Flutter dengan `r` di terminal
5. **Full restart** Flutter dengan `R` di terminal

---

## 📞 Jika Masih Bermasalah

1. **Stop semua**:
   - Stop Flutter app (Ctrl+C)
   - Stop backend (Ctrl+C)
   - Stop MySQL

2. **Start ulang**:
   ```bash
   # Terminal 1: Backend
   cd backend
   npm start
   
   # Terminal 2: Flutter
   flutter clean
   flutter pub get
   flutter run -d chrome
   ```

3. **Cek logs**:
   - Backend logs di terminal backend
   - Flutter logs di terminal flutter
   - MySQL logs di XAMPP/WAMP

---

**Setelah mengikuti panduan ini, aplikasi harus menampilkan 20 smartphone dengan foto asli dan fitur rekomendasi yang berfungsi!** 🎉

**Selamat mencoba!** 🚀
