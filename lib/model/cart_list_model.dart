class CartListModel {
  final int id;
  final String email;
  final String total;
  final String item;
  final String num;

  CartListModel({
    required this.id,
    required this.email,
    required this.item,
    required this.total,
    required this.num,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) {
    return CartListModel(
      id: json['id'],
      email: json['email'],
      total: json['total'],
      item: json['item'],
      num: json['number'],
    );
  }
}
