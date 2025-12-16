import '../models/smartphone.dart';

class SmartphoneService {
  // Menggunakan data lokal langsung agar gambar assets terbaca dengan baik
  // tanpa ketergantungan backend untuk saat ini.

  Future<List<Smartphone>> getSmartphones() async {
    // Simulasi delay sedikit agar terasa seperti loading
    await Future.delayed(const Duration(milliseconds: 500));
    return _localSmartphones;
  }

  Future<List<Smartphone>> getRecommendedSmartphones() async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Logika sorting berdasarkan skor performa rata-rata tertinggi
    List<Smartphone> sorted = List.from(_localSmartphones);
    sorted.sort((a, b) {
      double scoreA = _calculateOverallScore(a);
      double scoreB = _calculateOverallScore(b);
      return scoreB.compareTo(scoreA); // Descending (Tertinggi ke Terendah)
    });
    return sorted.take(10).toList();
  }

  Future<List<String>> getBrands() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _localSmartphones.map((s) => s.brand).toSet().toList()..sort();
  }

  Future<Smartphone> getSmartphoneById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _localSmartphones.firstWhere(
      (s) => s.id == id,
      orElse: () => _localSmartphones[0],
    );
  }

  Future<List<Smartphone>> searchSmartphones(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final lowerQuery = query.toLowerCase();
    return _localSmartphones
        .where(
          (s) =>
              s.name.toLowerCase().contains(lowerQuery) ||
              s.brand.toLowerCase().contains(lowerQuery) ||
              (s.processor?.toLowerCase().contains(lowerQuery) ?? false),
        )
        .toList();
  }

  Future<List<Smartphone>> getSmartphonesByBrand(String brand) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (brand.toLowerCase() == 'semua') return _localSmartphones;
    return _localSmartphones
        .where((s) => s.brand.toLowerCase() == brand.toLowerCase())
        .toList();
  }

  double _calculateOverallScore(Smartphone s) {
    return ((s.performanceScore ?? 0) +
            (s.cameraScore ?? 0) +
            (s.connectivityScore ?? 0) +
            (s.batteryScore ?? 0)) /
        4;
  }

  // Helper untuk membuat DateTime sekarang
  static final DateTime _now = DateTime.now();

  // Data Smartphone Lengkap dari CSV dengan path Assets
  static final List<Smartphone> _localSmartphones = [
    Smartphone(
      id: 1,
      name: 'Alcatel 1S',
      brand: 'Alcatel',
      price: 1599000,
      processor: 'Mediatek MT6762D Helio P22',
      ram: 3,
      memory: 32,
      screenSize: 4.1,
      performanceScore: 5.7,
      cameraScore: 4.8,
      connectivityScore: 5.5,
      batteryScore: 5.9,
      link:
          'https://www.tokopedia.com/mygadgetholic/alcatel-1s-5028y-smartphone-3-32gb-garansi-resmi-green',
      imageUrl: 'assets/alcatel_1S.jpg',
      description:
          'Alcatel 1S memberikan pengalaman smartphone yang solid dengan harga terjangkau. Dilengkapi dengan prosesor yang efisien dan baterai yang cukup untuk menemani aktivitas harian Anda.',
      specifications:
          'Prosesor: Mediatek MT6762D Helio P22\nRAM: 3GB\nMemori Internal: 32GB\nLayar: 6.22 inci HD+\nKamera Belakang: Triple Camera\nBaterai: 4000mAh',
      stock: 15,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 2,
      name: 'Alcatel 1SE',
      brand: 'Alcatel',
      price: 1599000,
      processor: 'Unisoc SC9863A',
      ram: 4,
      memory: 64,
      screenSize: 3.6,
      performanceScore: 5.4,
      cameraScore: 4.9,
      connectivityScore: 5.4,
      batteryScore: 5.7,
      link:
          'https://www.tokopedia.com/mygadgetholic/alcatel-1se-5030u-smartphone-4-64gb-garansi-resmi-green',
      imageUrl: 'assets/Alcatel 1SE.jpg',
      description:
          'Menampilkan tiga kamera di belakang untuk fotografi yang lebih baik di kelasnya, serta kapasitas memori yang lebih besar untuk menyimpan lebih banyak momen.',
      specifications:
          'Prosesor: Unisoc SC9863A\nRAM: 4GB\nMemori Internal: 64GB\nLayar: 6.22 inci HD+\nKamera: Triple AI Camera 13MP\nBaterai: 4000mAh',
      stock: 12,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 3,
      name: 'Asus Zenfone 4 Max',
      brand: 'ASUS',
      price: 1699000,
      processor: 'Qualcomm Snapdragon 430',
      ram: 3,
      memory: 32,
      screenSize: 4.1,
      performanceScore: 4.5,
      cameraScore: 3.7,
      connectivityScore: 5.7,
      batteryScore: 7.7,
      link:
          'https://www.tokopedia.com/mygadgetholic/asus-zenfone-4-max-zc554kl-smartphone-ram-3gb-rom-32gb-gold',
      imageUrl: 'assets/Zenfone 4 Max.webp',
      description:
          'Raja baterai di kelasnya. Zenfone 4 Max hadir dengan kapasitas baterai besar yang siap menemani Anda berhari-hari tanpa perlu sering mengisi daya.',
      specifications:
          'Prosesor: Snapdragon 430\nRAM: 3GB\nMemori: 32GB\nBaterai: 5000mAh (Bisa jadi powerbank)\nKamera: Dual Camera Wide Angle 13MP',
      stock: 8,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 4,
      name: 'Infinix Hot 10 Play',
      brand: 'Infinix',
      price: 1259000,
      processor: 'Mediatek Helio G25',
      ram: 2,
      memory: 32,
      screenSize: 4.3,
      performanceScore: 5.7,
      cameraScore: 4.6,
      connectivityScore: 6.7,
      batteryScore: 8.8,
      link:
          'https://www.tokopedia.com/mygadgetholic/infinix-hot-10-play-x688c-smartphone-2gb-32gb-garansi-resmi-morandi-green',
      imageUrl: 'assets/Infinix Hot 10 Play.jpg',
      description:
          'Layar sinematik yang sangat luas dipadukan dengan baterai monster, cocok untuk hiburan non-stop menonton film dan bermain game ringan.',
      specifications:
          'Prosesor: Helio G25\nRAM: 2GB\nMemori: 32GB\nLayar: 6.82 inci HD+ Video Playing Display\nBaterai: 6000mAh Power Marathon',
      stock: 20,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 5,
      name: 'Nokia C3',
      brand: 'Nokia',
      price: 1499000,
      processor: 'Unisoc SC9863A',
      ram: 2,
      memory: 16,
      screenSize: 3.7,
      performanceScore: 4.3,
      cameraScore: 3.5,
      connectivityScore: 3.5,
      batteryScore: 4.4,
      link:
          'https://www.tokopedia.com/nokia-mobile/nokia-c3-2-16gb-nordic-blue',
      imageUrl: 'assets/Nokia C3.png',
      description:
          'Durabilitas Nokia yang legendaris dengan desain yang kokoh dan baterai yang dapat dilepas, memberikan rasa aman dan nyaman dalam penggunaan.',
      specifications:
          'Prosesor: Octa-core 1.6GHz\nRAM: 2GB\nMemori: 16GB\nLayar: 5.99 inci HD+\nFitur: Fingerprint Sensor',
      stock: 10,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 6,
      name: 'Oppo A11',
      brand: 'OPPO',
      price: 1399000,
      processor: 'Mediatek Helio P35',
      ram: 2,
      memory: 32,
      screenSize: 3.9,
      performanceScore: 5.4,
      cameraScore: 4.5,
      connectivityScore: 4.5,
      batteryScore: 6.8,
      link:
          'https://www.tokopedia.com/oppo/oppo-a11k-smartphone-2gb-32gb-garansi-resmi-biru',
      imageUrl: 'assets/Oppo A11.jpg',
      description:
          'Desain elegan khas OPPO dengan kemampuan audio yang jernih, cocok untuk pecinta musik dan gaya hidup modern.',
      specifications:
          'Prosesor: Helio P35\nRAM: 2GB\nMemori: 32GB\nLayar: 6.5 inci Waterdrop Screen\nKamera: Dual Rear Camera 13MP+2MP',
      stock: 15,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 7,
      name: 'Oppo A15',
      brand: 'OPPO',
      price: 1799000,
      processor: 'Mediatek Helio P35',
      ram: 3,
      memory: 32,
      screenSize: 6.4,
      performanceScore: 5.9,
      cameraScore: 4.7,
      connectivityScore: 5.9,
      batteryScore: 6.9,
      link:
          'https://www.tokopedia.com/pvblicone/smartphone-oppo-a15-ram-3gb-internal-32gb-garansi-resmi-indonesia-hitam',
      imageUrl: 'assets/Oppo A15.jpg',
      description:
          'Triple kamera AI untuk setiap momen Anda. Desain ramping dan ergonomis membuatnya nyaman digenggam seharian.',
      specifications:
          'Prosesor: Helio P35\nRAM: 3GB\nMemori: 32GB\nKamera: Triple AI Camera 13MP\nLayar: 6.52 inci Eye Protection Screen',
      stock: 14,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 8,
      name: 'Oppo A11K',
      brand: 'OPPO',
      price: 1699000,
      processor: 'Mediatek Helio P35',
      ram: 2,
      memory: 32,
      screenSize: 3.9,
      performanceScore: 5.4,
      cameraScore: 4.5,
      connectivityScore: 4.5,
      batteryScore: 6.8,
      link:
          'https://www.tokopedia.com/supergadgettt/oppo-a11k-2-32-gb-galaxy-smartphone-ram-2gb-rom-32gb-murah-resmi-black',
      imageUrl: 'assets/Oppo A11K.jpg',
      description:
          'Pilihan cerdas dengan fitur pemindai sidik jari belakang untuk keamanan ekstra dan akses cepat.',
      specifications:
          'Prosesor: Helio P35\nRAM: 2GB\nMemori: 32GB\nBaterai: 4230mAh\nFitur: Fingerprint Sensor',
      stock: 16,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 9,
      name: 'Poco M3',
      brand: 'POCO',
      price: 1799000,
      processor: 'Qualcomm Snapdragon 662',
      ram: 4,
      memory: 64,
      screenSize: 7.0,
      performanceScore: 6.7,
      cameraScore: 6.8,
      connectivityScore: 7.0,
      batteryScore: 8.9,
      link:
          'https://www.tokopedia.com/xiaomi/xiaomi-official-poco-m3-4-64gb-snapdragon-662-mi-smartphone-power-black',
      imageUrl: 'assets/Poco M3.jpg',
      description:
          'More than you expect. POCO M3 menghadirkan desain berani, baterai jumbo, dan performa tinggi dengan Snapdragon 662.',
      specifications:
          'Prosesor: Snapdragon 662\nRAM: 4GB\nMemori: 64GB\nKamera: 48MP Triple Camera\nBaterai: 6000mAh High Cycle Battery\nLayar: FHD+ Dot Drop',
      stock: 25,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 10,
      name: 'Realme C20',
      brand: 'Realme',
      price: 1249000,
      processor: 'Mediatek Helio G35',
      ram: 2,
      memory: 32,
      screenSize: 5.8,
      performanceScore: 5.8,
      cameraScore: 3.4,
      connectivityScore: 5.6,
      batteryScore: 8.1,
      link:
          'https://www.tokopedia.com/mygadgetholic/realme-c20-smartphone-ram-2gb-rom-32gb-garansi-resmi-iron-grey',
      imageUrl: 'assets/Realme C20.jpg',
      description:
          'Smartphone entry-level raja baterai. Didesain dengan Geometric Art Design yang tahan gores dan tidak licin.',
      specifications:
          'Prosesor: Helio G35 Gaming Processor\nRAM: 2GB\nMemori: 32GB\nBaterai: 5000mAh Massive Battery\nLayar: 6.5 inci Large Display',
      stock: 22,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 11,
      name: 'Realme C11',
      brand: 'Realme',
      price: 1429000,
      processor: 'Mediatek Helio G35',
      ram: 2,
      memory: 32,
      screenSize: 6.3,
      performanceScore: 5.8,
      cameraScore: 4.4,
      connectivityScore: 5.1,
      batteryScore: 7.9,
      link:
          'https://www.tokopedia.com/mygadgetholic/realme-c11-smartphone-2-32gb-garansi-resmi-realme-green',
      imageUrl: 'assets/Realme C11.jpg',
      description:
          'Baterai cadas, seru tanpa batas. Cocok untuk gaming ringan berkat prosesor Helio G35 yang bertenaga.',
      specifications:
          'Prosesor: Helio G35\nRAM: 2GB\nMemori: 32GB\nKamera: Nightscape Dual Camera 13MP+2MP\nBaterai: 5000mAh',
      stock: 19,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 12,
      name: 'Realme C21',
      brand: 'Realme',
      price: 1700000,
      processor: 'Mediatek Helio G35',
      ram: 3,
      memory: 32,
      screenSize: 5.1,
      performanceScore: 5.9,
      cameraScore: 4.7,
      connectivityScore: 5.3,
      batteryScore: 8.1,
      link:
          'https://www.tokopedia.com/wijaya/realme-c21-smartphone-3-32gb-garansi-resmi',
      imageUrl: 'assets/Realme C21.jpg',
      description:
          'Tiga kamera, kualitas juara. Telah lolos sertifikasi TUV Rheinland untuk keandalan tinggi.',
      specifications:
          'Prosesor: Helio G35\nRAM: 3GB\nMemori: 32GB\nKamera: Triple AI Camera 13MP\nSertifikasi: TUV Rheinland High Reliability',
      stock: 17,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 13,
      name: 'Samsung Galaxy A02s',
      brand: 'Samsung',
      price: 1999000,
      processor: 'Snapdragon 450',
      ram: 4,
      memory: 64,
      screenSize: 3.6,
      performanceScore: 5.4,
      cameraScore: 5.0,
      connectivityScore: 5.2,
      batteryScore: 7.9,
      link:
          'https://www.tokopedia.com/global-teleshop/samsung-galaxy-a02s-smartphone-4-64gb-garansi-resmi-blue',
      imageUrl: 'assets/Samsung Galaxy.jpg',
      description:
          'Layar Infinity-V memukau dan triple kamera untuk menangkap detail lebih banyak.',
      specifications:
          'Prosesor: Snapdragon 450\nRAM: 4GB\nMemori: 64GB\nKamera: Triple Camera 13MP+2MP+2MP\nLayar: 6.5 inci PLS TFT LCD',
      stock: 30,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 14,
      name: 'Samsung Galaxy A10s',
      brand: 'Samsung',
      price: 1335000,
      processor: 'Mediatek MT6762 Helio P22',
      ram: 2,
      memory: 32,
      screenSize: 3.6,
      performanceScore: 5.2,
      cameraScore: 4.8,
      connectivityScore: 5.0,
      batteryScore: 5.8,
      link: 'https://www.kimovil.com/en/where-to-buy-samsung-galaxy-a10s',
      imageUrl: 'assets/Samsung Galaxy.jpg',
      description:
          'Upgrade performa dengan fingerprint sensor dan dual kamera untuk efek bokeh.',
      specifications:
          'Prosesor: Octa-core 2.0 GHz\nRAM: 2GB\nMemori: 32GB\nKamera: Dual 13MP+2MP\nKeamanan: Fingerprint Scanner',
      stock: 10,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 15,
      name: 'Samsung Galaxy A11',
      brand: 'Samsung',
      price: 1456000,
      processor: 'Snapdragon 450',
      ram: 3,
      memory: 32,
      screenSize: 3.6,
      performanceScore: 5.3,
      cameraScore: 5.1,
      connectivityScore: 4.8,
      batteryScore: 6.2,
      link:
          'https://www.tokopedia.com/prismaroxy/samsung-galaxy-a11-3-32gb-smartphone-garansi-resmi-putih',
      imageUrl: 'assets/Samsung Galaxy.jpg',
      description:
          'Desain punch-hole modern dengan lensa ultra-wide untuk foto pemandangan yang lebih luas.',
      specifications:
          'Prosesor: Octa-core 1.8 GHz\nRAM: 3GB\nMemori: 32GB\nKamera: Triple 13MP+5MP+2MP\nCharging: 15W Fast Charging',
      stock: 10,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 18,
      name: 'Samsung Galaxy J7',
      brand: 'Samsung',
      price: 1999000,
      processor: 'Exynos 7870',
      ram: 2,
      memory: 16,
      screenSize: 4.0,
      performanceScore: 4.7,
      cameraScore: 4.3,
      connectivityScore: 5.9,
      batteryScore: 5.5,
      link:
          'https://www.tokopedia.com/mygadgetholic/samsung-galaxy-j7-j710-smartphone-2gb-16gb-rom-hitam',
      imageUrl: 'assets/Samsung Galaxy.jpg',
      description:
          'Klasik yang tetap dicintai. Layar Super AMOLED yang jernih dan fitur Ultra Data Saving.',
      specifications:
          'Prosesor: Exynos 7870 Octa\nRAM: 2GB\nMemori: 16GB\nLayar: 5.5 inci Super AMOLED\nKamera: 13MP (f/1.9)',
      stock: 5,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 19,
      name: 'Sharp Aquos V SH-C02',
      brand: 'Sharp',
      price: 1874000,
      processor: 'Snapdragon 835',
      ram: 4,
      memory: 64,
      screenSize: 6.7,
      performanceScore: 6.2,
      cameraScore: 5.5,
      connectivityScore: 5.8,
      batteryScore: 4.8,
      link:
          'https://www.tokopedia.com/didik-electronic/promo-sharp-aquos-v-sh-c02-shc02-smartphone-64gb-ram-4gb-murah',
      imageUrl: 'assets/Sharp Aquos V.jpg',
      description:
          'Flagship lawas yang masih sangat bertenaga di kelasnya. Menggunakan prosesor seri 800 yang kencang.',
      specifications:
          'Prosesor: Snapdragon 835 (Flagship Tier)\nRAM: 4GB\nMemori: 64GB\nKamera: Dual 13MP dengan OIS\nFitur: NFC',
      stock: 8,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 20,
      name: 'Vivo Y20',
      brand: 'Vivo',
      price: 1900000,
      processor: 'Snapdragon 460',
      ram: 3,
      memory: 64,
      screenSize: 3.6,
      performanceScore: 6.3,
      cameraScore: 4.8,
      connectivityScore: 5.2,
      batteryScore: 8.2,
      link:
          'https://www.tokopedia.com/supergadgettt/vivo-y20-smartphone-3gb-64gb-garansi-resmi-dawn-white',
      imageUrl: 'assets/Vivo Y20.jpg',
      description:
          'Desain 2.5D yang memukau dengan Side Fingerprint. Performa gaming lancar dengan Snapdragon 460.',
      specifications:
          'Prosesor: Snapdragon 460\nRAM: 3GB\nMemori: 64GB\nBaterai: 5000mAh\nKamera: AI Triple Macro Camera',
      stock: 20,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 21,
      name: 'Vivo Y12S',
      brand: 'Vivo',
      price: 1899000,
      processor: 'Mediatek Helio P35',
      ram: 3,
      memory: 32,
      screenSize: 3.6,
      performanceScore: 5.7,
      cameraScore: 4.5,
      connectivityScore: 5.5,
      batteryScore: 7.9,
      link: 'https://www.tokopedia.com/prismaroxy/vivo-y1s-2-32gb-smartphone',
      imageUrl: 'assets/Vivo Y12S.png',
      description:
          'Side Fingerprint dan baterai 5000mAh dalam balutan desain Glacier Blue/Phantom Black yang menawan.',
      specifications:
          'Prosesor: Helio P35\nRAM: 3GB\nMemori: 32GB\nLayar: 6.51 inci Halo FullView\nBaterai: 5000mAh',
      stock: 15,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 22,
      name: 'Vivo Y91C',
      brand: 'Vivo',
      price: 1599000,
      processor: 'Mediatek Helio P22',
      ram: 2,
      memory: 32,
      screenSize: 5.6,
      performanceScore: 5.1,
      cameraScore: 3.8,
      connectivityScore: 4.0,
      batteryScore: 5.9,
      link:
          'https://www.tokopedia.com/andalascellularb/vivo-smartphone-y91c-2-32gb-6-2-inch-garansi-resmi-hitam',
      imageUrl: 'assets/Vivo Y91C.png',
      description:
          'Tampilan visual luas dengan Halo FullView Display. Dilengkapi Face Access untuk kemudahan membuka kunci.',
      specifications:
          'Prosesor: Helio P22\nRAM: 2GB\nMemori: 32GB\nLayar: 6.22 inci HD+\nWarna: Gradasi Fusion Black/Sunset Red',
      stock: 12,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 23,
      name: 'Redmi 9A',
      brand: 'Xiaomi',
      price: 1209000,
      processor: 'Mediatek Helio G25',
      ram: 2,
      memory: 32,
      screenSize: 6.5,
      performanceScore: 6.3,
      cameraScore: 6.0,
      connectivityScore: 7.6,
      batteryScore: 8.9,
      link:
          'https://www.tokopedia.com/global-teleshop/xiaomi-redmi-9a-smartphone-2-32gb-gray',
      imageUrl: 'assets/Redmi 9A.jpg',
      description:
          'Ponsel sejuta umat dengan layar besar 6.53 inci dan baterai 5000mAh. Pilihan terbaik di kelas entry-level.',
      specifications:
          'Prosesor: Helio G25\nRAM: 2GB\nMemori: 32GB\nLayar: 6.53 inci HD+ Dot Drop Display\nSertifikasi: TUV Rheinland Low Blue Light',
      stock: 28,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 24,
      name: 'Redmi 9C',
      brand: 'Xiaomi',
      price: 1550000,
      processor: 'Mediatek Helio G35',
      ram: 3,
      memory: 32,
      screenSize: 4.5,
      performanceScore: 5.8,
      cameraScore: 4.7,
      connectivityScore: 6.1,
      batteryScore: 7.8,
      link:
          'https://www.tokopedia.com/wijaya/xiaomi-redmi-9c-smartphone-3-32gb-garansi-resmi-tam',
      imageUrl: 'assets/Redmi 9C.jpg',
      description:
          'AI Triple Camera untuk fotografi yang lebih kreatif. Dilengkapi sensor sidik jari di belakang.',
      specifications:
          'Prosesor: Helio G35\nRAM: 3GB\nMemori: 32GB\nKamera: 13MP Triple AI Camera\nDesain: Tekstur anti bekas sidik jari',
      stock: 24,
      createdAt: _now,
      updatedAt: _now,
    ),
    Smartphone(
      id: 25,
      name: 'Redmi 9T',
      brand: 'Xiaomi',
      price: 2000000,
      processor: 'Snapdragon 662',
      ram: 4,
      memory: 64,
      screenSize: 7.0,
      performanceScore: 6.6,
      cameraScore: 7.1,
      connectivityScore: 7.5,
      batteryScore: 8.9,
      link:
          'https://www.tokopedia.com/wijaya/xiaomi-redmi-9t-smartphone-4-64gb-garansi-resmi',
      imageUrl: 'assets/Redmi 9T.jpg',
      description:
          'Jawaranya Baterai Gede. 6000mAh battery, 48MP AI Quad Camera, dan Dual Speakers. Paket lengkap!',
      specifications:
          'Prosesor: Snapdragon 662\nRAM: 4GB\nMemori: 64GB\nBaterai: 6000mAh\nAudio: Dual Speakers Hi-Res Audio Certified',
      stock: 32,
      createdAt: _now,
      updatedAt: _now,
    ),
  ];
}
