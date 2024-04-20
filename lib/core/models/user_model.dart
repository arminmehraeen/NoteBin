class UserModel {

  final int id ;
  final String name;
  final String email;
  final String created_at ;
  final String? image ;

  const UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.email,
    required this.created_at,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'email': email,
      'created_at': created_at,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String?,
      email: map['email'] as String,
      created_at: map['created_at'] as String,
    );
  }
}
