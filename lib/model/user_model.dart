class UserModel {
  final int id;
  final String name;
  final String email;
  final String address;
  final String number;
  final String fcmtoken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.number,
    required this.fcmtoken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: json['Address'] ?? "",
      number: json['number'] ?? "",
      fcmtoken: json['fcmtoken'] ?? "",
    );
  }
}
