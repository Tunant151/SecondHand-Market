class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final String status;
  final int viewsCount;
  final String district;
  final int categoryId;
  final int userId;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.status,
    required this.viewsCount,
    required this.district,
    required this.categoryId,
    required this.userId,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      images: List<String>.from(json['images']),
      status: json['status'],
      viewsCount: json['views_count'],
      district: json['district'],
      categoryId: json['category_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
