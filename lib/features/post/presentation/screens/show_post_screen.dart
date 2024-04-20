import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/models/commend_model.dart';
import 'package:notebin/core/widgets/default_widget.dart';
import 'package:notebin/core/widgets/form/custom_text_form_field.dart';
import 'package:notebin/features/post/presentation/bloc/post_bloc.dart';


import '../../../../core/models/action_status.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/user_profile_widget.dart';

class ShowPostScreen extends StatefulWidget {
  const ShowPostScreen({super.key, this.post});
  final post ;
  @override
  State<ShowPostScreen> createState() => _ShowPostScreenState();
}

class _ShowPostScreenState extends State<ShowPostScreen> {

  @override
  void initState() {
    super.initState();
    if(widget.post != null) {
      context.read<PostBloc>().add(LoadCommends(context: context, postId: widget.post['id'])) ;
    }
  }

  TextEditingController commentController = TextEditingController() ;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            trailing:  IconButton(onPressed: () {
    context.read<PostBloc>().add(DeletePost(context: context, postId: widget.post['id'].toString()));
    }, icon: const Icon(Icons.delete)),
            subtitle: Text(widget.post['title']),
            leading:
            UserProfileWidget(url: widget.post['user']['image'],),
            title:  Text(widget.post['user']['name']),
          ),
          widget.post['image'] == null ?
          Image.asset("assets/images/picture.jpg",width: double.infinity) :
          Image.network(ApiPath.imageHost + widget.post['image'],width: double.infinity),
          ListTile(
            title: const Text("Date :"),
            subtitle: Text(widget.post['created_at'] ?? ""),
          ),
          ListTile(
            title: const Text("Description :"),
            subtitle: Text(widget.post['body'] ?? ""),
          ),
          const Divider() ,
          ListTile(
            subtitle: Form(
                key: _formKey,
                child: Row(
              children: [
                Flexible(child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomTextFormField(
                      isDark: true,
                      controller: commentController, label: "Your comment"),
                )) ,
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PostBloc>().add(AddComment(context: context, comment: commentController.text, postId: widget.post['id'])) ;
                  }
                }, child: const Text("Confirm"))
              ],
            )),
            title: const Text("Comments :"),
          ),
          BlocConsumer<PostBloc, PostState>(builder: (context, state) {

            var status = state.commendsOfPost ;
            if (status is ActionWait) {
              return const SizedBox(
                  height: 200,
                  child: Center(child: Loading()));
            }

            if(status is ActionError) {
              return const SizedBox(
                  height: 200,
                  child: Center(child: Text("Error while get information")));
            }

            if (status is ActionSuccess) {
              List<CommendModel> data = status.data;

              if(data.isEmpty) {
                return const Center(child: Text("Empty Commends"), ) ;
              }

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    children: data.map((e) => ListTile(
                      trailing: e.isMine ?  IconButton(onPressed: () {

                        context.read<PostBloc>().add(DeleteCommend(context: context, commendId: e.id));

                      }, icon: const Icon(Icons.close,size: 12,)) : null,
                      leading: UserProfileWidget(url: e.user.image),
                      subtitle: Text("${e.user.name}\n${e.created_at}"),
                      isThreeLine: true,
                      title: Text(e.message),
                    )).toList()),
              );
            }

            return const DefaultWidget() ;
          }, listener: (context, state) async {

            if(state.addComment is ActionSuccess){
              context.read<PostBloc>().add(LoadCommends(context: context, postId: widget.post['id'],showLoad: false));
              commentController.clear();
            }

            if(state.deleteCommend is ActionSuccess){
              context.read<PostBloc>().add(LoadCommends(context: context, postId: widget.post['id'],showLoad: false));
            }

            if(state.deletePost is ActionSuccess) {
              Navigator.pop(context) ;
              context.read<PostBloc>().add(LoadPosts());
            }
          },)

        ],

      )
    );
  }
}
