class UserModel {
  final String username;
  final String email;
  final String role;

  UserModel({required this.username, required this.email, required this.role});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['fullname'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
    );
  }
}
