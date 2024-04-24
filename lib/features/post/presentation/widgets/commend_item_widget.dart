import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/models/commend_model.dart';
import 'package:notebin/features/post/presentation/bloc/post_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../core/widgets/user_profile_widget.dart';

class CommendItemWidget extends StatelessWidget {
  const CommendItemWidget(this.commend, {super.key, required this.onSwipe});
  final CommendModel commend ;
  final Function() onSwipe ;
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
        key: UniqueKey(),
        onRightSwipe: (details) => onSwipe(),
        child: ListTile(
          trailing: commend.isMine ?  IconButton(onPressed: () {
            context.read<PostBloc>().add(DeleteCommend(context: context, commendId: commend.id));
          }, icon: const Icon(Icons.close,size: 12,)) : null,
          leading: UserProfileWidget(url: commend.user.image),
          subtitle: Text("${commend.user.name}\n${commend.created_at}"),
          isThreeLine: true,
          title: Text(commend.message),
        )) ;
  }
}
