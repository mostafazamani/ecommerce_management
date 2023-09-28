class ProductModel {
  final String id;
  final String name;
  final String price;
  final String disprice;
  final String discont;
  final String category;
  final int available;
  final String details;
  final String image;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.disprice,
      required this.discont,
      required this.category,
      required this.available,
      required this.details,
      required this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        disprice: json['pricediscount'] ?? "",
        discont: json['discount'] ?? "",
        category: json['category'],
        available: int.parse(json['available']) ?? 0,
        details: json['details'],
        image: json['image'] ?? "");
  }
}
