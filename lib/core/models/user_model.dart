class UserModel {

  final int id ;
  final String name;
  final String email;
  final String created_at ;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.created_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'created_at': created_at,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      created_at: map['created_at'] as String,
    );
  }
}
