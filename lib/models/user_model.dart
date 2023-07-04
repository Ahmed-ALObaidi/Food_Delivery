class UserModel {
  int id;
  String phone;
  String email;
  String name;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });

  // factory is a special type of constractor
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['f_name'],
        email: json['email'],
        phone: json['phone'],
        orderCount: json['order_count']);
  }
}
