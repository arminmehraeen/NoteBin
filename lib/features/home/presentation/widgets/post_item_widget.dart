import 'package:flutter/material.dart';
import 'package:notebin/core/utils/constants.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({super.key,required this.post});
  final post ;
  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(

            decoration: BoxDecoration(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: Theme.of(context).primaryColor,),
            child: ListTile(
              subtitle: Text(widget.post['title']),
              leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,child: Icon(Icons.person,color: Theme.of(context).cardColor,),),
              title:  Text(widget.post['user']['name']),
            ),
          ),
          widget.post['image'] == null ?
          Image.asset("assets/images/picture.jpg",width: double.infinity,height: 150,fit: BoxFit.cover,) :
          Image.network(ApiPath.imageHost + widget.post['image'],width: double.infinity,height: 150,fit: BoxFit.cover,),
          Row(
            children: [

            ],
          )
          // ListTile(
          //   title: Text(widget.post['created_at']),
          //   subtitle:  Text(widget.post['body'],maxLines: 1,overflow: TextOverflow.clip),
          // )
        ],

      ),
    );
  }
}
