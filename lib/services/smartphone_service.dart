import '../models/smartphone.dart';

class SmartphoneService {
  // Simulate fetching smartphones from an API
  Future<List<Smartphone>> getSmartphones() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Return mock data
    return [
      Smartphone(
        id: 1,
        name: 'POCO M3',
        brand: 'POCO',
        price: 1799000,
        processor: 'Qualcomm Snapdragon 662 Octa-core',
        ram: 4,
        memory: 64,
        screenSize: 6.53,
        performanceScore: 6.7,
        cameraScore: 6.8,
        connectivityScore: 7.0,
        batteryScore: 8.9,
        link: 'https://www.tokopedia.com/xiaomi/xiaomi-official-poco-m3-4-64gb-snapdragon-662-mi-smartphone-power-black',
        imageUrl: 'https://placehold.co/300x300/ff6b6b/ffffff?text=POCO+M3',
        description: 'Performance-oriented device with Snapdragon chipset',
        specifications: 'Android 10 (MIUI 12), Full HD+ 1080 x 2340 pixels, 6000mAh battery',
        stock: 25,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Smartphone(
        id: 2,
        name: 'Realme C21',
        brand: 'Realme',
        price: 1700000,
        processor: 'MediaTek Helio G35 Octa-core',
        ram: 3,
        memory: 32,
        screenSize: 6.5,
        performanceScore: 5.9,
        cameraScore: 4.7,
        connectivityScore: 5.3,
        batteryScore: 8.1,
        link: 'https://www.tokopedia.com/wijaya/realme-c21-smartphone-3-32gb-garansi-resmi',
        imageUrl: 'https://placehold.co/300x300/5d5fef/ffffff?text=Realme+C21',
        description: 'Upgraded version of C20 with better camera',
        specifications: 'Android 11 (Realme UI), HD+ 720 x 1600 pixels, Triple AI Camera',
        stock: 17,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Smartphone(
        id: 3,
        name: 'Samsung Galaxy A02s',
        brand: 'Samsung',
        price: 1999000,
        processor: 'Qualcomm Snapdragon 450 Octa-core',
        ram: 4,
        memory: 64,
        screenSize: 6.5,
        performanceScore: 5.4,
        cameraScore: 5.0,
        connectivityScore: 5.2,
        batteryScore: 7.9,
        link: 'https://www.tokopedia.com/global-teleshop/samsung-galaxy-a02s-smartphone-4-64gb-garansi-resmi-blue',
        imageUrl: 'https://placehold.co/300x300/2c3e50/ffffff?text=Galaxy+A02s',
        description: 'Budget Samsung device with impressive battery life',
        specifications: 'Android 11 (One UI 3.1), HD+ 720 x 1600 pixels, Triple rear camera',
        stock: 30,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Smartphone(
        id: 4,
        name: 'Xiaomi Redmi 9T',
        brand: 'Xiaomi',
        price: 2000000,
        processor: 'Qualcomm Snapdragon 662 Octa-core',
        ram: 4,
        memory: 64,
        screenSize: 6.53,
        performanceScore: 6.6,
        cameraScore: 7.1,
        connectivityScore: 7.5,
        batteryScore: 8.9,
        link: 'https://www.tokopedia.com/wijaya/xiaomi-redmi-9t-smartphone-4-64gb-garansi-resmi',
        imageUrl: 'https://placehold.co/300x300/9b59b6/ffffff?text=Redmi+9T',
        description: 'Premium budget device with excellent battery life',
        specifications: 'Android 10 (MIUI 12), Full HD+ 1080 x 2340 pixels, 6000mAh battery',
        stock: 32,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Smartphone(
        id: 5,
        name: 'OPPO A15',
        brand: 'OPPO',
        price: 1799000,
        processor: 'MediaTek Helio P35 Octa-core',
        ram: 3,
        memory: 32,
        screenSize: 6.52,
        performanceScore: 5.9,
        cameraScore: 4.7,
        connectivityScore: 5.9,
        batteryScore: 6.9,
        link: 'https://www.tokopedia.com/pvblicone/smartphone-oppo-a15-ram-3gb-internal-32gb-garansi-resmi-indonesia-hitam',
        imageUrl: 'https://placehold.co/300x300/1abc9c/ffffff?text=OPPO+A15',
        description: 'Improved specs from A11 with better battery life',
        specifications: 'Android 10 (ColorOS 7), HD+ 720 x 1600 pixels, Triple AI Camera',
        stock: 14,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Smartphone(
        id: 6,
        name: 'Infinix Hot 10 Play',
        brand: 'Infinix',
        price: 1259000,
        processor: 'MediaTek Helio G35 Octa-core',
        ram: 2,
        memory: 32,
        screenSize: 6.82,
        performanceScore: 5.7,
        cameraScore: 4.6,
        connectivityScore: 6.7,
        batteryScore: 8.8,
        link: 'https://www.tokopedia.com/mygadgetholic/infinix-hot-10-play-x688c-smartphone-2gb-32gb-garansi-resmi-morandi-green',
        imageUrl: 'https://placehold.co/300x300/f39c12/ffffff?text=Infinix+Hot+10',
        description: 'Affordable option with large display and big battery',
        specifications: 'Android 10, HD+ 720 x 1640 pixels, 6000mAh battery, 12nm processor',
        stock: 20,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  // Get a single smartphone by ID
  Future<Smartphone?> getSmartphoneById(int id) async {
    final smartphones = await getSmartphones();
    return smartphones.firstWhere((smartphone) => smartphone.id == id, orElse: () => null);
  }

  // Search smartphones by brand or name
  Future<List<Smartphone>> searchSmartphones(String query) async {
    final allSmartphones = await getSmartphones();
    if (query.isEmpty) {
      return allSmartphones;
    }
    
    return allSmartphones
        .where((smartphone) =>
            smartphone.name.toLowerCase().contains(query.toLowerCase()) ||
            smartphone.brand.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}