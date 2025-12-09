# 🚀 PANDUAN INSTALASI CEPAT

## Langkah 1: Setup Database

1. **Buka XAMPP** dan start **Apache** dan **MySQL**

2. **Buka phpMyAdmin** di browser: `http://localhost/phpmyadmin`

3. **Import Database**:
   - Klik tab "SQL"
   - Copy seluruh isi file `database.sql`
   - Paste di SQL editor
   - Klik "Go" / "Kirim"

4. **Verifikasi**:
   - Database `smartphone_store` harus sudah terbuat
   - Ada 6 tabel: users, smartphones, orders, order_items, cart, reviews
   - Ada 24 data smartphone
   - Ada 1 admin user

## Langkah 2: Jalankan Backend

1. **Buka Terminal/CMD** di folder `backend`:
   ```bash
   cd backend
   ```

2. **Install Dependencies** (sudah dilakukan):
   ```bash
   npm install
   ```

3. **Jalankan Server**:
   ```bash
   npm start
   ```

4. **Cek Server**:
   - Server berjalan di: `http://localhost:5000`
   - Buka browser: `http://localhost:5000/api/health`
   - Harus muncul: `{"status":"OK","message":"Server is running"}`

## Langkah 3: Jalankan Frontend

### Opsi 1: Langsung Buka File
1. Buka file `frontend/index.html` di browser
2. Atau klik kanan → Open with → Chrome/Firefox

### Opsi 2: Menggunakan Live Server (Recommended)
1. Install extension "Live Server" di VS Code
2. Klik kanan `frontend/index.html`
3. Pilih "Open with Live Server"
4. Browser otomatis terbuka di `http://localhost:5500`

### Opsi 3: Python HTTP Server
```bash
cd frontend
python -m http.server 8080
```
Buka: `http://localhost:8080`

### Opsi 4: Node HTTP Server
```bash
cd frontend
npx http-server -p 8080
```
Buka: `http://localhost:8080`

## 🎯 Login Credentials

### Admin Dashboard
- **Username**: `admin`
- **Password**: `admin123`
- Setelah login, otomatis redirect ke dashboard

### User Biasa
- Klik tombol **Register** di homepage
- Isi form registrasi
- Login dengan akun yang dibuat

## ✅ Checklist Instalasi

- [ ] XAMPP Apache & MySQL running
- [ ] Database `smartphone_store` sudah diimport
- [ ] Backend dependencies sudah terinstall (`npm install`)
- [ ] Backend server running di port 5000
- [ ] Gambar sudah dicopy ke `backend/images/`
- [ ] Frontend bisa diakses di browser
- [ ] Bisa login sebagai admin
- [ ] Bisa registrasi user baru

## 🐛 Troubleshooting

### Backend tidak bisa start
```bash
# Cek apakah MySQL sudah running
# Cek file .env apakah konfigurasi database benar
# Pastikan port 5000 tidak digunakan aplikasi lain
```

### Gambar tidak muncul
```bash
# Copy gambar dari assets ke backend/images
cd aplikasi_toko
xcopy assets backend\images\ /E /I /Y
```

### CORS Error
```
Pastikan backend sudah running di http://localhost:5000
Jangan akses frontend dengan file:// protocol
Gunakan http:// protocol (Live Server atau HTTP Server)
```

### Database connection error
```
Cek di file backend/.env:
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=smartphone_store

Pastikan MySQL di XAMPP sudah running
```

## 📱 Cara Menggunakan

### Sebagai User:
1. Buka homepage
2. Lihat produk dan rekomendasi
3. Klik produk untuk detail
4. Register/Login
5. Tambah ke cart
6. Checkout

### Sebagai Admin:
1. Login dengan admin credentials
2. Otomatis masuk dashboard
3. Lihat statistik di Overview
4. Kelola produk di Products
5. Kelola orders di Orders
6. Lihat analytics

## 🎉 Selesai!

Aplikasi siap digunakan! Selamat mencoba! 🚀
