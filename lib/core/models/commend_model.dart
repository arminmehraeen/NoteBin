import 'package:notebin/core/models/user_model.dart';

class CommendModel {
  final int id;

  final int user_id;

  final int post_id;

  final int? commend_id;

  final String message;

  final String created_at;

  final UserModel user;

  final bool isMine;

  final List<CommendModel> children;

  const CommendModel(
      {required this.id,
      required this.user_id,
      required this.post_id,
      this.commend_id,
      required this.message,
      required this.created_at,
      required this.user,
      required this.children,
      this.isMine = false});

  factory CommendModel.fromMap(Map<String, dynamic> map, int? user_id) {
    return CommendModel(
        id: map['id'] as int,
        user_id: map['user_id'] as int,
        post_id: map['post_id'] as int,
        commend_id: map['commend_id'],
        message: map['message'] as String,
        created_at: map['created_at'] as String,
        user: UserModel.fromMap(map['user']),
        children: (map['children'] as List)
            .map((e) => CommendModel.fromMap(e, user_id))
            .toList(),
        isMine: user_id == map['user_id'] as int);
  }
}
