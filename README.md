# 📱 SmartPhone Store - Aplikasi Toko Smartphone

Aplikasi toko smartphone lengkap dengan frontend modern, backend Node.js/Express, dan database MySQL.

## 🌟 Fitur Utama

### User Features
- ✅ **Registrasi & Login** - Sistem autentikasi dengan JWT
- 🛍️ **Katalog Produk** - Lihat semua smartphone dengan detail lengkap
- 🎯 **Rekomendasi Cerdas** - Rekomendasi berdasarkan:
  - Baterai tahan lama
  - Kamera terbaik
  - Performa tinggi
  - Harga terbaik
- 🛒 **Shopping Cart** - Keranjang belanja dengan update real-time
- 📦 **Order Management** - Buat dan lacak pesanan
- ⭐ **Rating & Review** - Lihat rating produk

### Admin Features
- 📊 **Dashboard Analytics** - Statistik lengkap toko
- 📱 **Product Management** - CRUD produk dengan mudah
- 🛒 **Order Management** - Kelola status pesanan
- 👥 **User Management** - Lihat data pengguna
- 📈 **Sales Analytics** - Analisis penjualan per brand
- 📉 **Inventory Tracking** - Monitor stok produk

## 🚀 Teknologi yang Digunakan

### Backend
- **Node.js** - Runtime JavaScript
- **Express.js** - Web framework
- **MySQL** - Database
- **JWT** - Authentication
- **bcryptjs** - Password hashing

### Frontend
- **HTML5** - Struktur
- **CSS3** - Styling dengan gradient modern
- **Vanilla JavaScript** - Logic & API integration
- **Inter Font** - Typography

## 📋 Prasyarat

- Node.js (v14 atau lebih baru)
- MySQL (v5.7 atau lebih baru)
- XAMPP atau MySQL Server
- Browser modern (Chrome, Firefox, Edge)

## 🔧 Instalasi

### 1. Setup Database

1. Buka **phpMyAdmin** atau MySQL client
2. Import file `database.sql`:
   ```sql
   source database.sql
   ```
   Atau copy-paste isi file ke SQL tab di phpMyAdmin

3. Database `smartphone_store` akan dibuat otomatis dengan:
   - Tabel users, smartphones, orders, cart, reviews
   - Data sample 24 smartphone
   - Admin default: username `admin`, password `admin123`

### 2. Setup Backend

1. Buka terminal di folder `backend`:
   ```bash
   cd backend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Edit file `.env` jika perlu (sesuaikan dengan konfigurasi MySQL Anda):
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=
   DB_NAME=smartphone_store
   ```

4. Salin gambar smartphone dari folder `assets` ke `backend/images`:
   ```bash
   # Windows
   xcopy ..\assets backend\images\ /E /I
   
   # Linux/Mac
   cp -r ../assets/* backend/images/
   ```

5. Jalankan server:
   ```bash
   npm start
   ```
   
   Server akan berjalan di `http://localhost:5000`

### 3. Setup Frontend

1. Buka folder `frontend`
2. Buka `index.html` dengan browser atau gunakan Live Server
3. Atau jalankan simple HTTP server:
   ```bash
   # Python 3
   python -m http.server 8080
   
   # Node.js
   npx http-server -p 8080
   ```

4. Akses aplikasi di `http://localhost:8080`

## 👤 Login Credentials

### Admin
- **Username**: `admin`
- **Email**: `admin@smartphonestore.com`
- **Password**: `admin123`

### User
Registrasi user baru melalui halaman utama

## 📁 Struktur Project

```
aplikasi_toko/
├── backend/
│   ├── config/
│   │   └── database.js          # Konfigurasi database
│   ├── middleware/
│   │   └── auth.js               # JWT middleware
│   ├── routes/
│   │   ├── auth.js               # Login & register
│   │   ├── smartphones.js        # CRUD smartphones
│   │   ├── cart.js               # Shopping cart
│   │   ├── orders.js             # Order management
│   │   └── dashboard.js          # Admin analytics
│   ├── images/                   # Folder gambar produk
│   ├── .env                      # Environment variables
│   ├── package.json
│   └── server.js                 # Main server
├── frontend/
│   ├── css/
│   │   ├── style.css             # Main styles
│   │   └── dashboard.css         # Dashboard styles
│   ├── js/
│   │   ├── app.js                # Main app logic
│   │   └── dashboard.js          # Dashboard logic
│   ├── index.html                # Homepage
│   └── dashboard.html            # Admin dashboard
├── assets/                       # Gambar smartphone
├── database.sql                  # Database schema & data
└── README.md
```

## 🎨 Fitur Desain

- **Modern UI/UX** - Desain modern dengan gradient dan animasi
- **Responsive** - Tampil sempurna di desktop, tablet, dan mobile
- **Glassmorphism** - Efek kaca modern
- **Smooth Animations** - Transisi halus dan micro-interactions
- **Color Palette** - Warna vibrant dan harmonis
- **Typography** - Inter font untuk keterbacaan optimal

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/register` - Register user baru
- `POST /api/auth/login` - Login user

### Smartphones
- `GET /api/smartphones` - Get all smartphones
- `GET /api/smartphones/:id` - Get smartphone detail
- `GET /api/smartphones/recommendations/best?criteria=` - Get recommendations
- `POST /api/smartphones` - Add smartphone (admin)
- `PUT /api/smartphones/:id` - Update smartphone (admin)
- `DELETE /api/smartphones/:id` - Delete smartphone (admin)

### Cart
- `GET /api/cart` - Get user cart
- `POST /api/cart` - Add to cart
- `PUT /api/cart/:id` - Update cart item
- `DELETE /api/cart/:id` - Remove from cart

### Orders
- `GET /api/orders` - Get user orders
- `GET /api/orders/all` - Get all orders (admin)
- `GET /api/orders/:id` - Get order detail
- `POST /api/orders` - Create order
- `PUT /api/orders/:id/status` - Update order status (admin)

### Dashboard
- `GET /api/dashboard/stats` - Get dashboard statistics (admin)

## 📊 Database Schema

### Users
- id, username, email, password, full_name, role (user/admin), timestamps

### Smartphones
- id, name, brand, price, processor, ram, memory, screen, performance, camera, connectivity, battery, link, image_url, stock, timestamps

### Orders
- id, user_id, total_amount, status, shipping_address, timestamps

### Order Items
- id, order_id, smartphone_id, quantity, price

### Cart
- id, user_id, smartphone_id, quantity, created_at

### Reviews
- id, user_id, smartphone_id, rating, comment, created_at

## 🎯 Cara Menggunakan

### Sebagai User:
1. Buka `index.html`
2. Klik **Register** untuk membuat akun
3. Login dengan akun yang dibuat
4. Jelajahi produk dan rekomendasi
5. Tambahkan produk ke keranjang
6. Checkout untuk membuat pesanan

### Sebagai Admin:
1. Login dengan credentials admin
2. Otomatis redirect ke dashboard
3. Kelola produk, orders, dan lihat analytics
4. Update status pesanan
5. Tambah/edit/hapus produk

## 🐛 Troubleshooting

### Backend tidak bisa connect ke database
- Pastikan MySQL sudah running
- Cek credentials di file `.env`
- Pastikan database `smartphone_store` sudah dibuat

### Gambar produk tidak muncul
- Pastikan folder `backend/images` ada
- Salin semua gambar dari `assets` ke `backend/images`
- Pastikan nama file di database sesuai dengan nama file gambar

### CORS Error
- Pastikan backend sudah running di port 5000
- Cek konfigurasi CORS di `server.js`

### Token expired
- Login ulang untuk mendapatkan token baru
- Token berlaku 24 jam

## 📝 Notes

- Password admin di-hash dengan bcrypt
- JWT token berlaku 24 jam
- Semua harga dalam Rupiah
- Rating produk dalam skala 1-10
- Stock otomatis berkurang saat order dibuat

## 🔐 Security

- Password di-hash dengan bcrypt (10 rounds)
- JWT untuk authentication
- Protected admin routes
- SQL injection prevention dengan prepared statements
- XSS protection

## 📈 Future Enhancements

- [ ] Upload gambar produk
- [ ] Payment gateway integration
- [ ] Email notifications
- [ ] Advanced search & filters
- [ ] Wishlist feature
- [ ] Product comparison
- [ ] Customer reviews & ratings
- [ ] Sales reports export (PDF/Excel)

## 👨‍💻 Developer

Dibuat dengan ❤️ untuk project aplikasi toko smartphone

## 📄 License

MIT License - Bebas digunakan untuk keperluan apapun

---

**Happy Coding! 🚀**
