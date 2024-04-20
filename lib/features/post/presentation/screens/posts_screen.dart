import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/widgets/default_widget.dart';
import 'package:notebin/core/widgets/loading.dart';
import 'package:notebin/features/post/presentation/bloc/post_bloc.dart';
import 'package:notebin/features/post/presentation/screens/show_post_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/models/action_status.dart';
import '../widgets/post_item_widget.dart';
import 'add_post_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {



  void onAddPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen(),)) ;
  }

  @override
  void initState() {
    context.read<PostBloc>().add(LoadPosts());
    super.initState();
  }


  void onTap (var post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowPostScreen(post: post))) ;
  }

  RefreshController refreshController = RefreshController(initialRefresh: false);


  void _onRefresh() async{
    context.read<PostBloc>().add(LoadPosts());
    await Future.delayed(const Duration(milliseconds: 500)) ;
    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      child: BlocConsumer<PostBloc, PostState>(builder: (context, state) {

        var status = state.posts ;
        if (status is ActionWait) {
          return const Center(child: Loading());
        }

        if(status is ActionError) {
          return const Center(child: Text("Error while get information"));
        }

        if (status is ActionSuccess) {
          List data = status.data;

          if(data.isEmpty) {
            return const Center(child: Text("Empty Post"), ) ;
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 2,),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return GestureDetector(
                    onTap: () => onTap(item),
                    child: PostItemWidget(post: item)
                );
              },),
          );
        }

        return const DefaultWidget();
      }, listener: (context, state) {

      })
    );
  }


}
