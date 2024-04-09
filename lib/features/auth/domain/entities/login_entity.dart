class LoginEntity {
  final String email;
  final String password;

  const LoginEntity({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory LoginEntity.fromMap(Map<String, dynamic> map) {
    return LoginEntity(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
