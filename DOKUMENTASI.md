# 📋 DOKUMENTASI LENGKAP - SmartPhone Store

## 📁 Struktur Project

```
aplikasi_toko/
│
├── 📂 backend/                      # Backend Node.js/Express
│   ├── 📂 config/
│   │   └── database.js              # Konfigurasi koneksi MySQL
│   ├── 📂 middleware/
│   │   └── auth.js                  # JWT authentication middleware
│   ├── 📂 routes/
│   │   ├── auth.js                  # Routes: login, register
│   │   ├── smartphones.js           # Routes: CRUD smartphones, recommendations
│   │   ├── cart.js                  # Routes: shopping cart operations
│   │   ├── orders.js                # Routes: order management
│   │   └── dashboard.js             # Routes: admin dashboard statistics
│   ├── 📂 images/                   # Folder untuk gambar produk
│   ├── .env                         # Environment variables (DB config, JWT secret)
│   ├── package.json                 # Dependencies & scripts
│   ├── server.js                    # Main server file
│   └── generate_hash.js             # Utility untuk generate bcrypt hash
│
├── 📂 frontend/                     # Frontend HTML/CSS/JS
│   ├── 📂 css/
│   │   ├── style.css                # Main stylesheet (modern design)
│   │   └── dashboard.css            # Dashboard-specific styles
│   ├── 📂 js/
│   │   ├── app.js                   # Main app logic (user interface)
│   │   └── dashboard.js             # Dashboard logic (admin interface)
│   ├── index.html                   # Homepage (user interface)
│   └── dashboard.html               # Admin dashboard
│
├── 📂 assets/                       # Gambar smartphone original
│   ├── alcatel_1S.jpg
│   ├── Alcatel 1SE.jpg
│   ├── Nokia C3.png
│   └── ... (20 gambar lainnya)
│
├── 📄 database.sql                  # Database schema & sample data
├── 📄 update_admin_password.sql     # Script update password admin
├── 📄 README.md                     # Dokumentasi utama (English)
├── 📄 INSTALASI.md                  # Panduan instalasi (Indonesian)
└── 📄 DOKUMENTASI.md                # File ini
```

## 🗄️ Database Schema

### Table: users
```sql
id              INT PRIMARY KEY AUTO_INCREMENT
username        VARCHAR(50) UNIQUE NOT NULL
email           VARCHAR(100) UNIQUE NOT NULL
password        VARCHAR(255) NOT NULL          -- Bcrypt hashed
full_name       VARCHAR(100) NOT NULL
role            ENUM('user', 'admin')          -- Role-based access
created_at      TIMESTAMP
updated_at      TIMESTAMP
```

### Table: smartphones
```sql
id              INT PRIMARY KEY AUTO_INCREMENT
name            VARCHAR(100) NOT NULL
brand           VARCHAR(50) NOT NULL
price           DECIMAL(10, 2) NOT NULL
processor       VARCHAR(50)
ram             INT                             -- GB
memory          INT                             -- GB
screen          DECIMAL(3, 1)                   -- Rating 1-10
performance     DECIMAL(3, 1)                   -- Rating 1-10
camera          DECIMAL(3, 1)                   -- Rating 1-10
connectivity    DECIMAL(3, 1)                   -- Rating 1-10
battery         DECIMAL(3, 1)                   -- Rating 1-10
link            TEXT                            -- Tokopedia link
image_url       VARCHAR(255)                    -- Filename gambar
description     TEXT
stock           INT DEFAULT 0
created_at      TIMESTAMP
updated_at      TIMESTAMP
```

### Table: orders
```sql
id                  INT PRIMARY KEY AUTO_INCREMENT
user_id             INT NOT NULL                -- FK to users
total_amount        DECIMAL(10, 2) NOT NULL
status              ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled')
shipping_address    TEXT NOT NULL
created_at          TIMESTAMP
updated_at          TIMESTAMP
```

### Table: order_items
```sql
id              INT PRIMARY KEY AUTO_INCREMENT
order_id        INT NOT NULL                    -- FK to orders
smartphone_id   INT NOT NULL                    -- FK to smartphones
quantity        INT NOT NULL
price           DECIMAL(10, 2) NOT NULL         -- Price saat order dibuat
```

### Table: cart
```sql
id              INT PRIMARY KEY AUTO_INCREMENT
user_id         INT NOT NULL                    -- FK to users
smartphone_id   INT NOT NULL                    -- FK to smartphones
quantity        INT DEFAULT 1
created_at      TIMESTAMP
```

### Table: reviews
```sql
id              INT PRIMARY KEY AUTO_INCREMENT
user_id         INT NOT NULL                    -- FK to users
smartphone_id   INT NOT NULL                    -- FK to smartphones
rating          INT CHECK (1-5)                 -- Star rating
comment         TEXT
created_at      TIMESTAMP
```

## 🔌 API Endpoints

### Authentication (`/api/auth`)

#### POST /api/auth/register
Register user baru
```json
Request:
{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "password123",
  "full_name": "John Doe"
}

Response:
{
  "message": "User registered successfully",
  "userId": 2
}
```

#### POST /api/auth/login
Login user/admin
```json
Request:
{
  "username": "admin",
  "password": "admin123"
}

Response:
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "admin",
    "email": "admin@smartphonestore.com",
    "full_name": "Administrator",
    "role": "admin"
  }
}
```

### Smartphones (`/api/smartphones`)

#### GET /api/smartphones
Get all smartphones dengan rating
```json
Response:
[
  {
    "id": 1,
    "name": "Poco M3",
    "brand": "Poco",
    "price": 1799000,
    "processor": "Snapdragon",
    "ram": 4,
    "memory": 64,
    "screen": 7.0,
    "performance": 6.7,
    "camera": 6.8,
    "connectivity": 7.0,
    "battery": 8.9,
    "link": "https://...",
    "image_url": "Poco M3.jpg",
    "stock": 25,
    "avg_rating": 4.5,
    "review_count": 10
  },
  ...
]
```

#### GET /api/smartphones/:id
Get smartphone detail dengan reviews
```json
Response:
{
  "id": 1,
  "name": "Poco M3",
  ...,
  "reviews": [
    {
      "id": 1,
      "rating": 5,
      "comment": "Excellent phone!",
      "username": "johndoe",
      "full_name": "John Doe",
      "created_at": "2024-12-09T..."
    }
  ]
}
```

#### GET /api/smartphones/recommendations/best?criteria=battery
Get rekomendasi berdasarkan kriteria
- `criteria`: overall, battery, camera, performance, budget, premium
```json
Response: [Array of 6 smartphones sorted by criteria]
```

#### POST /api/smartphones (Admin Only)
Tambah smartphone baru
```json
Headers:
{
  "Authorization": "Bearer <token>"
}

Request:
{
  "name": "iPhone 13",
  "brand": "Apple",
  "price": 12000000,
  "processor": "A15 Bionic",
  "ram": 4,
  "memory": 128,
  "screen": 9.0,
  "performance": 9.5,
  "camera": 9.0,
  "connectivity": 9.0,
  "battery": 8.0,
  "link": "https://...",
  "image_url": "iphone13.jpg",
  "stock": 10
}
```

#### PUT /api/smartphones/:id (Admin Only)
Update smartphone

#### DELETE /api/smartphones/:id (Admin Only)
Delete smartphone

### Cart (`/api/cart`)

#### GET /api/cart
Get user's cart
```json
Headers:
{
  "Authorization": "Bearer <token>"
}

Response:
[
  {
    "id": 1,
    "user_id": 2,
    "smartphone_id": 5,
    "quantity": 2,
    "name": "Poco M3",
    "brand": "Poco",
    "price": 1799000,
    "image_url": "Poco M3.jpg",
    "stock": 25
  }
]
```

#### POST /api/cart
Add item to cart
```json
Request:
{
  "smartphone_id": 5,
  "quantity": 1
}
```

#### PUT /api/cart/:id
Update cart item quantity
```json
Request:
{
  "quantity": 3
}
```

#### DELETE /api/cart/:id
Remove item from cart

### Orders (`/api/orders`)

#### GET /api/orders
Get user's orders

#### GET /api/orders/all (Admin Only)
Get all orders

#### GET /api/orders/:id
Get order detail dengan items

#### POST /api/orders
Create order from cart
```json
Request:
{
  "shipping_address": "Jl. Contoh No. 123, Jakarta"
}

Response:
{
  "message": "Order created successfully",
  "orderId": 1
}
```

#### PUT /api/orders/:id/status (Admin Only)
Update order status
```json
Request:
{
  "status": "shipped"
}
```

### Dashboard (`/api/dashboard`)

#### GET /api/dashboard/stats (Admin Only)
Get dashboard statistics
```json
Response:
{
  "totalUsers": 50,
  "totalOrders": 120,
  "totalRevenue": 180000000,
  "totalProducts": 24,
  "recentOrders": [...],
  "topProducts": [...],
  "salesByBrand": [
    {
      "brand": "Xiaomi",
      "sales_count": 45,
      "total_quantity": 67
    }
  ],
  "ordersByStatus": [
    {
      "status": "pending",
      "count": 15
    }
  ]
}
```

## 🎨 Frontend Components

### index.html (User Interface)
**Sections:**
1. **Hero** - Welcome section dengan stats
2. **Recommendations** - 6 produk rekomendasi dengan filter
3. **Products** - Semua produk dengan filter & sort
4. **About** - Informasi toko

**Modals:**
- Login Modal
- Register Modal
- Product Detail Modal
- Cart Modal

**Features:**
- Smooth scroll navigation
- Real-time cart count
- Product filtering (brand, price, sort)
- Recommendation filtering (battery, camera, performance, budget)
- Add to cart
- Checkout

### dashboard.html (Admin Interface)
**Sections:**
1. **Overview** - Statistics cards, charts, recent orders, top products
2. **Products** - Product management table dengan CRUD
3. **Orders** - Order management dengan status update
4. **Users** - User list (placeholder)
5. **Analytics** - Performance metrics & inventory status

**Features:**
- Real-time statistics
- Interactive charts (bar charts)
- Product CRUD operations
- Order status management
- Inventory tracking
- Low stock alerts

## 🔐 Security Features

### Password Hashing
```javascript
// Menggunakan bcryptjs dengan 10 rounds
const hashedPassword = await bcrypt.hash(password, 10);
```

### JWT Authentication
```javascript
// Token berlaku 24 jam
const token = jwt.sign(
  { id, username, role },
  process.env.JWT_SECRET,
  { expiresIn: '24h' }
);
```

### Protected Routes
```javascript
// Middleware untuk cek authentication
authMiddleware(req, res, next)

// Middleware untuk cek admin role
adminMiddleware(req, res, next)
```

### SQL Injection Prevention
```javascript
// Menggunakan prepared statements
await db.query('SELECT * FROM users WHERE id = ?', [userId]);
```

## 🎯 Business Logic

### Recommendation System
```javascript
// Kriteria rekomendasi:
- overall: performance DESC, camera DESC, battery DESC
- battery: battery DESC, performance DESC
- camera: camera DESC, performance DESC
- performance: performance DESC, ram DESC
- budget: price ASC, performance DESC
- premium: price DESC, performance DESC
```

### Order Creation Flow
1. Validasi cart tidak kosong
2. Cek stok semua item
3. Hitung total amount
4. Begin transaction
5. Create order record
6. Create order_items records
7. Update stock (decrement)
8. Clear cart
9. Commit transaction

### Stock Management
- Stock berkurang otomatis saat order dibuat
- Validasi stock sebelum checkout
- Low stock alert di dashboard (< 10 units)

## 🎨 Design System

### Color Palette
```css
--primary: #6366f1        /* Indigo */
--primary-dark: #4f46e5
--primary-light: #818cf8
--secondary: #ec4899      /* Pink */
--accent: #f59e0b         /* Amber */
--success: #10b981        /* Green */
--danger: #ef4444         /* Red */
--dark: #0f172a           /* Slate */
--gray: #64748b
```

### Gradients
```css
--gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
--gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%)
--gradient-accent: linear-gradient(135deg, #fad0c4 0%, #ffd1ff 100%)
```

### Typography
- Font: Inter (Google Fonts)
- Weights: 300, 400, 500, 600, 700, 800

### Spacing
- Container max-width: 1200px
- Section padding: 6rem 0
- Card padding: 2rem
- Gap: 1rem, 1.5rem, 2rem, 3rem

### Border Radius
- Small: 8px
- Medium: 12px
- Large: 20px
- Pill: 50px

### Shadows
```css
--shadow: 0 10px 30px rgba(0, 0, 0, 0.1)
--shadow-lg: 0 20px 60px rgba(0, 0, 0, 0.15)
```

## 📊 Data Flow

### User Registration Flow
```
User Input → Frontend Validation → API Call → 
Backend Validation → Hash Password → Insert DB → 
Return Success → Show Login Modal
```

### Login Flow
```
User Input → API Call → Find User → 
Verify Password → Generate JWT → 
Return Token + User Data → Store in LocalStorage → 
Update UI → Redirect if Admin
```

### Add to Cart Flow
```
Click Add to Cart → Check Auth → API Call → 
Check Existing Item → Insert/Update Cart → 
Update Cart Count → Show Success
```

### Checkout Flow
```
Click Checkout → Prompt Address → API Call → 
Validate Cart → Check Stock → Begin Transaction → 
Create Order → Create Items → Update Stock → 
Clear Cart → Commit → Show Success
```

## 🔧 Configuration

### Environment Variables (.env)
```
PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=smartphone_store
JWT_SECRET=your_jwt_secret_key_change_this_in_production
```

### CORS Configuration
```javascript
app.use(cors()); // Allow all origins for development
```

### Database Connection Pool
```javascript
connectionLimit: 10
queueLimit: 0
```

## 📝 Notes & Best Practices

1. **Always use prepared statements** untuk prevent SQL injection
2. **Hash passwords** dengan bcrypt sebelum simpan ke database
3. **Validate input** di frontend dan backend
4. **Use transactions** untuk operasi yang melibatkan multiple tables
5. **Check authentication** untuk protected routes
6. **Handle errors gracefully** dengan try-catch
7. **Use environment variables** untuk sensitive data
8. **Keep token in localStorage** untuk persistent login
9. **Update cart count** setelah setiap cart operation
10. **Refresh dashboard data** setelah CRUD operations

## 🚀 Deployment Checklist

- [ ] Change JWT_SECRET to strong random string
- [ ] Set proper CORS origin
- [ ] Use HTTPS in production
- [ ] Set secure cookie flags
- [ ] Enable rate limiting
- [ ] Add input sanitization
- [ ] Set up proper logging
- [ ] Configure database backup
- [ ] Optimize images
- [ ] Minify CSS/JS
- [ ] Add error tracking (Sentry)
- [ ] Set up monitoring

---

**Dokumentasi ini dibuat untuk memudahkan development dan maintenance aplikasi SmartPhone Store** 📱✨
