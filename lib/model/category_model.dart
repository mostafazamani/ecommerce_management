class CategoryModel {
  final int id;
  final String catname;

  CategoryModel({required this.id, required this.catname});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], catname: json['name']);
  }
}
