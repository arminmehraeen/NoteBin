class RegisterEntity {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

  factory RegisterEntity.fromMap(Map<String, dynamic> map) {
    return RegisterEntity(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['passwordConfirmation'] as String,
    );
  }
}
