import 'package:flutter/material.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({super.key,required this.post});
  final post ;
  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          subtitle: Text(widget.post['title']),
          leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,child: Icon(Icons.person,color: Theme.of(context).cardColor,),),
          title:  Text(widget.post['user']['name']),
        ),
        Image.asset("assets/images/picture.jpg",width: double.infinity,height: 150,fit: BoxFit.cover,),
        ListTile(
          title: Text(widget.post['created_at']),
          subtitle:  Text(widget.post['body'],maxLines: 1,overflow: TextOverflow.clip),
        )
      ],

    );
  }
}
