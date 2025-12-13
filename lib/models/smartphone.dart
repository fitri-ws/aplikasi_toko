class Smartphone {
  final int id;
  final String name;
  final String brand;
  final double price;
  final String? processor;
  final int? ram;
  final int? memory;
  final double? screenSize;
  final double? performanceScore;
  final double? cameraScore;
  final double? connectivityScore;
  final double? batteryScore;
  final String? link;
  final String? imageUrl;
  final String? description;
  final String? specifications;
  final int? stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  Smartphone({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.processor,
    this.ram,
    this.memory,
    this.screenSize,
    this.performanceScore,
    this.cameraScore,
    this.connectivityScore,
    this.batteryScore,
    this.link,
    this.imageUrl,
    this.description,
    this.specifications,
    this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a Smartphone from JSON
  factory Smartphone.fromJson(Map<String, dynamic> json) {
    return Smartphone(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: (json['price'] is int) ? json['price'].toDouble() : json['price'],
      processor: json['processor'],
      ram: json['ram'],
      memory: json['memory'],
      screenSize: json['screen_size']?.toDouble(),
      performanceScore: json['performance_score']?.toDouble(),
      cameraScore: json['camera_score']?.toDouble(),
      connectivityScore: json['connectivity_score']?.toDouble(),
      batteryScore: json['battery_score']?.toDouble(),
      link: json['link'],
      imageUrl: json['image_url'],
      description: json['description'],
      specifications: json['specifications'],
      stock: json['stock'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert Smartphone to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'processor': processor,
      'ram': ram,
      'memory': memory,
      'screen_size': screenSize,
      'performance_score': performanceScore,
      'camera_score': cameraScore,
      'connectivity_score': connectivityScore,
      'battery_score': batteryScore,
      'link': link,
      'image_url': imageUrl,
      'description': description,
      'specifications': specifications,
      'stock': stock,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}