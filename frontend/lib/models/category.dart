class Category {
  final int id;
  final String name;
  final String icon;
  final int? parentId;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      parentId: json['parent_id'],
    );
  }
}
