class Category {
  final String title;
  final String imagePath;
  final bool comingSoon;

  Category({required this.title, required this.imagePath, this.comingSoon = false});
}

class CategoryResponseModel {
  final bool status;
  final String message;
  final List<CategoryModel> categories;

  CategoryResponseModel({required this.status, required this.message, required this.categories});

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(status: json['status'] ?? false, message: json['message'] ?? '', categories: (json['Categories'] as List<dynamic>?)?.map((e) => CategoryModel.fromJson(e)).toList() ?? []);
  }

  Map<String, dynamic> toJson() => {'status': status, 'message': message, 'Categories': categories.map((e) => e.toJson()).toList()};
}

class CategoryModel {
  final int categoryId;
  final String categoryName;
  final String categoryIcon;
  final String createdAt;
  final String? updatedAt;

  CategoryModel({required this.categoryId, required this.categoryName, required this.categoryIcon, required this.createdAt, this.updatedAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id_PK'] ?? 0,
      categoryName: json['category_name'] ?? '',
      categoryIcon: json['category_icon'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'], // can be null
    );
  }

  Map<String, dynamic> toJson() => {'category_id_PK': categoryId, 'category_name': categoryName, 'category_icon': categoryIcon, 'created_at': createdAt, 'updated_at': updatedAt};
}
