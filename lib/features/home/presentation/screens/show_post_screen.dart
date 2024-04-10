import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/features/home/presentation/bloc/home_bloc.dart';

class ShowPostScreen extends StatefulWidget {
  const ShowPostScreen({super.key, this.post});
  final post ;
  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {


  var post ;

  @override
  void initState() {
    post = widget.post ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
        actions: [
          IconButton(onPressed: () {
            context.read<HomeBloc>().add(DeletePost(context: context, postId: post['id'].toString()));
          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            subtitle: Text(widget.post['title']),
            leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,child: Icon(Icons.person,color: Theme.of(context).cardColor,),),
            title:  Text(widget.post['user']['name']),
          ),
          Image.asset("assets/images/picture.jpg",width: double.infinity),
          ListTile(
            title: const Text("Date :"),
            subtitle: Text(widget.post['created_at']),
          ),
          ListTile(
            title: const Text("Description :"),
            subtitle: Text(widget.post['body']),
          ),
          Divider() ,
          ListTile(
            title: Text("Comments :"),
          ),
          Expanded(child: Center( child: CircularProgressIndicator(),))

        ],

      )
    );
  }
}
