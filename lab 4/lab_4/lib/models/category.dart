class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(String json) {
    return Category(name: json);
  }

  String toJson() {
    return name;
  }

  @override
  String toString() {
    return 'Category{name: $name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
