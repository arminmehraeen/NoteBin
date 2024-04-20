import 'package:flutter/material.dart';
import 'package:notebin/core/utils/constants.dart';

import '../../../../core/widgets/user_profile_widget.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({super.key,required this.post});
  final post ;
  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  @override
  Widget build(BuildContext context) {
    return

      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Flexible(child: ListTile(
                isThreeLine: true,
                subtitle:Text("${widget.post['user']['name']}\n${widget.post['created_at']}"),
                leading: UserProfileWidget(url: widget.post['user']['image'],),
                title:Text(widget.post['title']),
              ),),
              SizedBox(
                height: 100,
                width: 100,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: widget.post['image'] == null ?
                Image.asset("assets/images/picture.jpg",width: double.infinity,height: 150,fit: BoxFit.cover,) :
                Image.network(ApiPath.imageHost + widget.post['image'],width: double.infinity,height: 150,fit: BoxFit.cover,),)
              )
            ],
          ),
        ),
      );

    //   Container(
    //   margin: const EdgeInsets.all(0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //
    //         decoration: BoxDecoration(
    //   borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
    //           color: Theme.of(context).primaryColor,),
    //         child:
    //       ),
    //
    //       Row(
    //         children: [
    //
    //         ],
    //       )
    //     ],
    //
    //   ),
    // );
  }
}
