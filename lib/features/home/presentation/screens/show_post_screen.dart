import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:notebin/core/widgets/default_widget.dart';
import 'package:notebin/core/widgets/form/custom_text_form_field.dart';


import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/loading.dart';
import '../bloc/home_bloc.dart';

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
      context.read<HomeBloc>().add(LoadCommends(context: context, postId: widget.post['id'])) ;
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
    context.read<HomeBloc>().add(DeletePost(context: context, postId: widget.post['id'].toString()));
    }, icon: const Icon(Icons.delete)),
            subtitle: Text(widget.post['title']),
            leading: CircleAvatar(backgroundColor: Theme.of(context).primaryColor,child: Icon(Icons.person,color: Theme.of(context).cardColor,),),
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
                    context.read<HomeBloc>().add(AddComment(context: context, comment: commentController.text, postId: widget.post['id'])) ;
                  }
                }, child: const Text("Confirm"))
              ],
            )),
            title: const Text("Comments :"),
          ),
          BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {

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
              List data = status.data;

              if(data.isEmpty) {
                return const Center(child: Text("Empty Commends"), ) ;
              }

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                    children: data.where((e) => e['message'] != null).toList().map((e) => ListTile(

                      leading: const Icon(Icons.person),
                      title: Text(e['message'].toString()),
                    )).toList()),
              );
            }

            return const DefaultWidget() ;
          }, listener: (context, state) async {

            if(state.addComment is ActionSuccess){
              context.read<HomeBloc>().add(LoadCommends(context: context, postId: widget.post['id'],showLoad: false));
            }

            if(state.deletePost is ActionSuccess) {

              Navigator.pop(context) ;
              var snackBar = SnackBar(
                content: Text((state.deletePost as ActionSuccess).data,),
              );
              context.read<HomeBloc>().add(HomeDataLoad());
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },)

        ],

      )
    );
  }
}
