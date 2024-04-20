import 'package:dio/dio.dart';

class RegisterEntity {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final MultipartFile? image ;

  const RegisterEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      if(image != null) 'image': image,
      'password_confirmation': passwordConfirmation,
    };
  }

  factory RegisterEntity.fromMap(Map<String, dynamic> map) {
    return RegisterEntity(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      image: map['image'] ,
      passwordConfirmation: map['passwordConfirmation'] as String,
    );
  }
}
