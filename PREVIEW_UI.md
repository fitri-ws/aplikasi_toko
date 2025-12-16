# 📸 PREVIEW APLIKASI - Deskripsi Tampilan

Dokumen ini menjelaskan tampilan aplikasi yang sudah diperbaiki.

## 🎨 Design Overview

Aplikasi menggunakan design modern dengan:
- **Color Scheme**: Blue gradient sebagai primary color
- **Typography**: Google Fonts Poppins
- **Style**: Modern, clean, dengan rounded corners dan shadows
- **Layout**: Responsive dengan grid dan list views

---

## 📱 Screen by Screen

### 1. Logo Screen
**Tampilan Awal**
- Logo aplikasi "PhoneStation"
- Background gradient blue
- Transisi smooth ke login screen
- Duration: 2-3 detik

---

### 2. Login Screen
**Elemen UI:**
- Header dengan logo
- Email input field
- Password input field
- "Login" button (blue, rounded)
- "Belum punya akun? Register" link
- "Login sebagai Admin" link

**Warna:**
- Background: White dengan blue accent
- Button: Blue gradient
- Input fields: White dengan border

---

### 3. Register Screen
**Elemen UI:**
- Form fields:
  - Full Name
  - Username
  - Email
  - Phone Number
  - Password
  - Confirm Password
- "Register" button
- "Sudah punya akun? Login" link

**Validasi:**
- Required fields
- Email format
- Password match
- Phone number format

---

### 4. Home Screen - Header
**Tampilan:**
```
┌─────────────────────────────────────────┐
│  Halo, [Nama User]! 👋                  │
│  Temukan smartphone impianmu            │
│                              [👤] [⋮]   │
└─────────────────────────────────────────┘
```

**Fitur:**
- Gradient blue background
- Rounded bottom corners
- Shadow effect
- Profile icon (kanan atas)
- Menu icon untuk logout

**Warna:**
- Background: Blue gradient (#2196F3 → lighter blue)
- Text: White
- Icons: White

---

### 5. Home Screen - Search Bar
**Tampilan:**
```
┌─────────────────────────────────────────┐
│  🔍  Cari smartphone...                 │
└─────────────────────────────────────────┘
```

**Fitur:**
- White background
- Rounded corners (15px)
- Shadow effect
- Search icon (blue)
- Placeholder text (grey)

**Interaksi:**
- Real-time search saat user mengetik
- Filter hasil berdasarkan nama, brand, processor

---

### 6. Home Screen - Brand Filter
**Tampilan:**
```
┌──────┬──────┬──────┬──────┬──────┬──────┐
│Semua │Xiaomi│Samsung│OPPO │Realme│ POCO │
└──────┴──────┴──────┴──────┴──────┴──────┘
```

**Fitur:**
- Horizontal scrollable chips
- Active chip: Blue background, white text
- Inactive chip: Light blue background, blue text
- Smooth scroll animation

**Warna:**
- Selected: Blue (#2196F3)
- Unselected: Light blue (#E3F2FD)

---

### 7. Home Screen - Tab Bar
**Tampilan:**
```
┌─────────────────┬─────────────────┐
│ ⭐ Rekomendasi  │  📱 Semua HP    │
└─────────────────┴─────────────────┘
```

**Fitur:**
- 2 tabs dengan icons
- Active tab: Blue background, white text
- Inactive tab: Grey text
- Smooth transition animation

---

### 8. Rekomendasi Tab
**Card Layout:**
```
┌────────────────────────────────────────┐
│ [#1] [Image]  Brand                    │
│              Product Name               │
│              ⭐ 7.5                     │
│              4GB / 64GB                 │
│              Rp 1.799.000          [>] │
└────────────────────────────────────────┘
```

**Fitur:**
- Ranking badge (#1, #2, #3, etc.)
  - #1: Gold gradient
  - #2: Silver gradient
  - #3: Bronze gradient
  - Others: Orange gradient
- Product image (90x90, rounded)
- Brand name (small, blue)
- Product name (bold, black)
- Overall score dengan star icon
- RAM/Storage info
- Price (green, bold)
- Chevron icon (grey)

**Warna:**
- Card: White dengan shadow
- Badge: Gradient sesuai rank
- Brand: Blue (#2196F3)
- Price: Green (#4CAF50)

---

### 9. Semua HP Tab (Grid View)
**Grid Layout:**
```
┌──────────┬──────────┐
│ [Image]  │ [Image]  │
│  Brand   │  Brand   │
│  Name    │  Name    │
│  ⭐ 7.5  │  ⭐ 6.8  │
│  Price   │  Price   │
└──────────┴──────────┘
```

**Fitur:**
- 2 columns grid
- Compact card design
- Product image (full width)
- Brand badge (small)
- Product name (2 lines max)
- Star rating
- Price (green)

**Spacing:**
- Gap between cards: 12px
- Padding: 16px

---

### 10. Detail Screen - Hero Image
**Tampilan:**
```
┌─────────────────────────────────────────┐
│                                         │
│                                         │
│           [Product Image]               │
│             (Large)                     │
│                                         │
│                                         │
└─────────────────────────────────────────┘
```

**Fitur:**
- Height: 350px
- Gradient background (grey → white)
- Centered image
- Hero animation dari list
- Loading spinner saat load
- Fallback icon jika error

---

### 11. Detail Screen - Header Section
**Tampilan:**
```
┌─────────────────────────────────────────┐
│  [Brand Badge]                          │
│                                         │
│  Product Name                           │
│  (Large, Bold)                          │
│                                         │
│  ⭐⭐⭐⭐☆ 7.5/10                        │
│                                         │
│  ┌───────────────────────────────────┐ │
│  │ Harga                         💰  │ │
│  │ Rp 1.799.000                      │ │
│  └───────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

**Fitur:**
- Brand badge (blue border, rounded)
- Large product name
- 5-star rating bar
- Overall score display
- Price card dengan gradient green
- Price icon

---

### 12. Detail Screen - Quick Specs
**Tampilan:**
```
┌──────────────┬──────────────┐
│  💜 Memory   │  💙 Screen   │
│  Processor   │  6.53"       │
└──────────────┴──────────────┘
┌──────────────┬──────────────┐
│  🧡 RAM      │  💚 Storage  │
│  4 GB        │  64 GB       │
└──────────────┴──────────────┘
```

**Fitur:**
- 2x2 grid layout
- Color-coded cards:
  - Purple: Processor
  - Blue: Screen Size
  - Orange: RAM
  - Teal: Storage
- Icons untuk setiap spec
- Rounded corners
- Light background dengan border

---

### 13. Detail Screen - Performance Scores
**Tampilan:**
```
⭐ Skor Performa

Performa          7.5/10
[████████░░] (Blue)

Kamera            6.8/10
[███████░░░] (Purple)

Konektivitas      7.0/10
[███████░░░] (Orange)

Baterai           8.9/10
[█████████░] (Green)
```

**Fitur:**
- Progress bars untuk setiap kategori
- Color-coded bars
- Numeric score display
- Rounded progress bars
- Label di kiri, score di kanan

---

### 14. Detail Screen - Stock Information
**Tampilan untuk Stock Tersedia (>5):**
```
┌─────────────────────────────────────────┐
│  ✅  Stok Tersedia                      │
│      25 unit tersedia                   │
└─────────────────────────────────────────┘
```

**Tampilan untuk Stock Terbatas (1-5):**
```
┌─────────────────────────────────────────┐
│  ⚠️  Stok Terbatas!                     │
│      3 unit tersedia                    │
└─────────────────────────────────────────┘
```

**Tampilan untuk Stock Habis (0):**
```
┌─────────────────────────────────────────┐
│  ❌  Stok Habis                         │
│      Produk sedang tidak tersedia       │
└─────────────────────────────────────────┘
```

**Warna:**
- Available: Green gradient
- Limited: Orange gradient
- Out of stock: Red gradient

---

### 15. Detail Screen - Bottom Bar
**Tampilan:**
```
┌─────────────────────────────────────────┐
│  [🛒 Beli Sekarang]                     │
└─────────────────────────────────────────┘
```

**Fitur:**
- Fixed bottom position
- Full width button
- Blue background (jika available)
- Grey background (jika out of stock)
- Shopping cart icon
- Shadow effect
- Disabled state jika stock habis

---

### 16. Buy Dialog
**Tampilan:**
```
┌─────────────────────────────────────────┐
│  🛒 Beli Sekarang                       │
│                                         │
│  Apakah Anda ingin membeli              │
│  [Product Name]?                        │
│                                         │
│           [Batal]  [Beli]               │
└─────────────────────────────────────────┘
```

**Fitur:**
- Rounded dialog
- Shopping cart icon
- Product name
- Cancel button (grey)
- Buy button (blue)

---

### 17. Success Snackbar
**Tampilan:**
```
┌─────────────────────────────────────────┐
│  Produk telah ditambahkan ke keranjang  │
└─────────────────────────────────────────┘
```

**Fitur:**
- Green background
- White text
- Rounded corners
- Floating style
- Auto dismiss (3 seconds)

---

## 🎨 Color Palette

### Primary Colors
- **Primary Blue**: #2196F3
- **Light Blue**: #64B5F6
- **Dark Blue**: #1976D2
- **Blue 50**: #E3F2FD

### Secondary Colors
- **Green**: #4CAF50 (Price, Success)
- **Orange**: #FF9800 (Warning, Limited Stock)
- **Red**: #F44336 (Error, Out of Stock)
- **Purple**: #9C27B0 (Accent)
- **Teal**: #009688 (Accent)
- **Amber**: #FFC107 (Gold badge)

### Neutral Colors
- **White**: #FFFFFF
- **Grey 100**: #F5F5F5
- **Grey 200**: #EEEEEE
- **Grey 300**: #E0E0E0
- **Grey 600**: #757575
- **Grey 700**: #616161
- **Black**: #000000

---

## 📐 Spacing & Sizing

### Padding
- **Small**: 8px
- **Medium**: 16px
- **Large**: 20px

### Border Radius
- **Small**: 8px
- **Medium**: 12px
- **Large**: 20px
- **Extra Large**: 30px

### Font Sizes
- **Caption**: 11-12px
- **Body**: 14-16px
- **Subtitle**: 18-20px
- **Title**: 24-26px
- **Large Title**: 28px

### Icon Sizes
- **Small**: 16px
- **Medium**: 24px
- **Large**: 32px
- **Extra Large**: 40px

---

## 🎭 Animations & Transitions

### Page Transitions
- **Type**: Slide from right
- **Duration**: 300ms
- **Curve**: easeInOut

### Tab Switching
- **Type**: Fade + Slide
- **Duration**: 200ms
- **Curve**: easeOut

### Card Tap
- **Type**: Ripple effect
- **Color**: Light blue
- **Duration**: 300ms

### Image Loading
- **Type**: Fade in
- **Duration**: 200ms
- **Placeholder**: Circular progress indicator

---

## ✨ Special Effects

### Shadows
- **Card Shadow**: 
  - Color: Grey 300
  - Blur: 10px
  - Offset: (0, 5)

- **Header Shadow**:
  - Color: Blue 200
  - Blur: 10px
  - Offset: (0, 5)

### Gradients
- **Header Gradient**: Blue 600 → Blue 400
- **Price Card**: Green 50 → Green 100
- **Stock Available**: Green 50 → Green 100
- **Stock Limited**: Orange 50 → Orange 100
- **Stock Out**: Red 50 → Red 100

---

## 📱 Responsive Behavior

### Portrait Mode (Default)
- Grid: 2 columns
- Card width: ~45% screen width
- Image aspect ratio: 1:1

### Landscape Mode
- Grid: 3-4 columns (auto-adjust)
- Smaller card heights
- Optimized for wider screens

### Small Screens (<360px width)
- Smaller font sizes
- Reduced padding
- Single column for some sections

### Large Screens (>600px width)
- Larger images
- More spacing
- Better use of horizontal space

---

## 🎯 User Experience Highlights

1. **Loading States**
   - Circular progress indicators
   - Skeleton screens (optional)
   - Smooth transitions

2. **Empty States**
   - Large icons
   - Helpful messages
   - Suggestions for actions

3. **Error States**
   - Fallback images
   - Error messages
   - Retry options

4. **Success Feedback**
   - Snackbars
   - Dialog confirmations
   - Visual indicators

---

**Design ini dibuat untuk memberikan:**
- ✅ Visual appeal yang tinggi
- ✅ User experience yang smooth
- ✅ Informasi yang jelas dan terstruktur
- ✅ Interaksi yang intuitif
- ✅ Performance yang optimal
