import 'package:flutter/material.dart';

import '../utils/constants.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key, this.url, this.size});
  final String? url ;
  final double? size ;
  @override
  Widget build(BuildContext context) {
    return

      CircleAvatar(
          backgroundImage: url != null ? NetworkImage(ApiPath.imageHost + url!,) : null,
          backgroundColor: Theme.of(context).primaryColor,minRadius: size , child:

          url != null ? Container() :

      Icon(Icons.person,color: Theme.of(context).cardColor,)) ;

  }
}
