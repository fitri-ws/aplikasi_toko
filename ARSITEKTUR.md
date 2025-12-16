# 🏗️ ARSITEKTUR APLIKASI TOKO HP

## 📊 Diagram Arsitektur

```
┌─────────────────────────────────────────────────────────────┐
│                     FLUTTER APP (Frontend)                   │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │ Logo Screen  │  │ Login/       │  │ Home Screen  │     │
│  │              │→ │ Register     │→ │              │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                            │                │
│                                            ↓                │
│  ┌──────────────────────────────────────────────────┐     │
│  │          Home Screen Features                     │     │
│  │  • Tab 1: ⭐ Rekomendasi (Top Phones)            │     │
│  │  • Tab 2: 📱 Semua HP (All Phones Grid)          │     │
│  │  • Search Bar                                     │     │
│  │  • Brand Filter Chips                             │     │
│  └──────────────────────────────────────────────────┘     │
│                          │                                  │
│                          ↓                                  │
│  ┌──────────────────────────────────────────────────┐     │
│  │      Smartphone Detail Screen                     │     │
│  │  • Hero Image                                     │     │
│  │  • Specs Cards (Processor, RAM, Storage, Screen) │     │
│  │  • Performance Scores (Progress Bars)             │     │
│  │  • Description & Full Specifications              │     │
│  │  • Stock Information                              │     │
│  │  • Buy Button                                     │     │
│  └──────────────────────────────────────────────────┘     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
                          │
                          │ HTTP Requests
                          │ (JSON)
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                   NODE.JS BACKEND (API)                      │
│                                                              │
│  ┌──────────────────────────────────────────────────┐     │
│  │              Express.js Server                    │     │
│  │              Port: 5000                           │     │
│  └──────────────────────────────────────────────────┘     │
│                          │                                  │
│  ┌──────────────────────────────────────────────────┐     │
│  │                API Endpoints                      │     │
│  │                                                   │     │
│  │  GET  /api/smartphones                           │     │
│  │  GET  /api/smartphones/recommended               │     │
│  │  GET  /api/smartphones/brands                    │     │
│  │  GET  /api/smartphones/search?q=query            │     │
│  │  GET  /api/smartphones/brand/:brand              │     │
│  │  GET  /api/smartphones/:id                       │     │
│  │  POST /api/smartphones (admin)                   │     │
│  │  PUT  /api/smartphones/:id (admin)               │     │
│  │  DEL  /api/smartphones/:id (admin)               │     │
│  │                                                   │     │
│  │  POST /api/auth/register                         │     │
│  │  POST /api/auth/login                            │     │
│  │  GET  /api/auth/me                               │     │
│  └──────────────────────────────────────────────────┘     │
│                          │                                  │
└──────────────────────────┼──────────────────────────────────┘
                          │
                          │ SQL Queries
                          ↓
┌─────────────────────────────────────────────────────────────┐
│                    MySQL DATABASE                            │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │   users      │  │ smartphones  │  │   orders     │     │
│  │              │  │              │  │              │     │
│  │ • id         │  │ • id         │  │ • id         │     │
│  │ • username   │  │ • name       │  │ • user_id    │     │
│  │ • email      │  │ • brand      │  │ • total      │     │
│  │ • password   │  │ • price      │  │ • status     │     │
│  │ • full_name  │  │ • processor  │  │ • address    │     │
│  │ • role       │  │ • ram        │  │              │     │
│  └──────────────┘  │ • memory     │  └──────────────┘     │
│                    │ • screen_size│                        │
│  ┌──────────────┐  │ • perf_score │  ┌──────────────┐     │
│  │ order_items  │  │ • cam_score  │  │   reviews    │     │
│  │              │  │ • conn_score │  │              │     │
│  │ • id         │  │ • batt_score │  │ • id         │     │
│  │ • order_id   │  │ • image_url  │  │ • user_id    │     │
│  │ • phone_id   │  │ • description│  │ • phone_id   │     │
│  │ • quantity   │  │ • specs      │  │ • rating     │     │
│  │ • price      │  │ • stock      │  │ • comment    │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
│                                                              │
│  ┌──────────────┐                                           │
│  │    cart      │                                           │
│  │              │                                           │
│  │ • id         │                                           │
│  │ • user_id    │                                           │
│  │ • phone_id   │                                           │
│  │ • quantity   │                                           │
│  └──────────────┘                                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Data Flow

### 1. User Opens App
```
Flutter App → Logo Screen → Login/Register → Home Screen
```

### 2. Loading Smartphones
```
Home Screen → smartphone_service.dart → HTTP GET /api/smartphones
                                      ↓
Backend API → MySQL Query → Return JSON
                                      ↓
Flutter App ← Parse JSON ← Response
                                      ↓
Display in Grid/List
```

### 3. Search Flow
```
User types in search bar
    ↓
_filterSmartphones() called
    ↓
Filter local list OR
HTTP GET /api/smartphones/search?q=query
    ↓
Update UI with filtered results
```

### 4. View Detail
```
User taps smartphone card
    ↓
Navigate to SmartphoneDetailScreen
    ↓
Display all information:
  • Image (cached)
  • Specs
  • Scores
  • Description
  • Stock
    ↓
User can buy (dialog)
```

### 5. Recommendation System
```
HTTP GET /api/smartphones/recommended
    ↓
Backend calculates:
  overall_score = (perf + cam + conn + batt) / 4
    ↓
ORDER BY overall_score DESC
    ↓
LIMIT 10
    ↓
Return top phones
    ↓
Display with ranking badges
```

## 📦 Package Dependencies

### Flutter (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2
  http: ^1.1.0                    # HTTP requests
  cached_network_image: ^3.3.0    # Image caching
  flutter_rating_bar: ^4.0.1      # Star ratings
  google_fonts: ^6.1.0            # Typography
```

### Backend (package.json)
```json
{
  "dependencies": {
    "express": "^4.18.2",         // Web framework
    "mysql2": "^3.6.5",           // MySQL driver
    "cors": "^2.8.5",             // CORS middleware
    "bcryptjs": "^2.4.3",         // Password hashing
    "jsonwebtoken": "^9.0.2",     // JWT auth
    "dotenv": "^16.3.1",          // Environment vars
    "body-parser": "^1.20.2"      // Request parsing
  }
}
```

## 🎨 UI Component Hierarchy

```
HomeScreen
├── Container (Gradient Background)
│   ├── SafeArea
│   │   ├── _buildHeader()
│   │   │   ├── Gradient Container
│   │   │   ├── Welcome Text
│   │   │   ├── Profile Button
│   │   │   └── Logout Menu
│   │   ├── _buildSearchBar()
│   │   │   └── TextField with Icon
│   │   ├── _buildBrandFilter()
│   │   │   └── Horizontal ListView of FilterChips
│   │   ├── _buildTabBar()
│   │   │   └── TabBar (Rekomendasi | Semua HP)
│   │   └── TabBarView
│   │       ├── _buildRecommendedTab()
│   │       │   └── ListView of _buildSmartphoneCard()
│   │       │       ├── Rank Badge
│   │       │       ├── Cached Image
│   │       │       ├── Brand, Name
│   │       │       ├── Overall Score
│   │       │       ├── RAM/Storage
│   │       │       └── Price
│   │       └── _buildAllPhonesTab()
│   │           └── GridView of _buildGridSmartphoneCard()
│   │               ├── Cached Image
│   │               ├── Brand, Name
│   │               ├── Star Rating
│   │               └── Price
```

```
SmartphoneDetailScreen
├── CustomScrollView
│   ├── SliverAppBar
│   └── SliverToBoxAdapter
│       ├── _buildImageSection()
│       │   └── Hero + CachedNetworkImage
│       ├── _buildHeaderSection()
│       │   ├── Brand Badge
│       │   ├── Product Name
│       │   ├── Rating Bar
│       │   └── Price Card
│       ├── _buildQuickSpecs()
│       │   └── 2x2 Grid of Spec Cards
│       ├── _buildScoreSection()
│       │   └── 4 Progress Bars
│       ├── _buildDescriptionSection()
│       ├── _buildSpecificationsSection()
│       └── _buildStockSection()
└── _buildBottomBar()
    └── Buy Button
```

## 🔐 Authentication Flow

```
User enters credentials
    ↓
POST /api/auth/login
    ↓
Backend validates:
  • Check user exists
  • Verify password (bcrypt)
    ↓
Generate JWT token
    ↓
Return token + user data
    ↓
Flutter saves to SharedPreferences
    ↓
Include token in future requests:
  Authorization: Bearer <token>
```

## 📊 Database Relationships

```
users (1) ──────── (N) orders
                      │
                      │
                      └── (N) order_items ──── (1) smartphones

users (1) ──────── (N) cart ──────── (1) smartphones

users (1) ──────── (N) reviews ──── (1) smartphones
```

## 🎯 Key Features Implementation

### 1. Rekomendasi System
- **Logic**: Calculate overall score from 4 metrics
- **Formula**: `(performance + camera + connectivity + battery) / 4`
- **Sorting**: DESC by overall_score, then ASC by price
- **Filter**: Only show phones with stock > 0

### 2. Search Functionality
- **Frontend**: Real-time filtering of local data
- **Backend**: SQL LIKE query on name, brand, processor
- **UX**: Instant results as user types

### 3. Brand Filter
- **Data**: Fetch unique brands from database
- **UI**: Horizontal scrollable chips
- **State**: Active chip highlighted
- **Logic**: Filter smartphones by selected brand

### 4. Image Handling
- **Package**: cached_network_image
- **Features**:
  - Automatic caching
  - Placeholder while loading
  - Error fallback (icon)
  - Memory efficient

### 5. Score Visualization
- **Component**: LinearProgressIndicator
- **Colors**: Category-specific (blue, purple, orange, green)
- **Range**: 0-10 scale
- **Display**: Progress bar + numeric value

## 🚀 Performance Optimizations

1. **Parallel Loading**
   ```dart
   Future.wait([
     getSmartphones(),
     getRecommendedSmartphones(),
     getBrands(),
   ])
   ```

2. **Image Caching**
   - Reduces network calls
   - Faster subsequent loads
   - Automatic memory management

3. **Lazy Loading**
   - ListView.builder / GridView.builder
   - Only builds visible items
   - Efficient for large lists

4. **State Management**
   - Local state with setState
   - Minimal rebuilds
   - Efficient updates

---

**Arsitektur ini dirancang untuk:**
- ✅ Scalability
- ✅ Maintainability
- ✅ Performance
- ✅ User Experience
- ✅ Code Organization
