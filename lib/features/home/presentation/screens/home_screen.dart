import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/features/home/presentation/cubit/home_cubit.dart';
import 'package:notebin/features/post/presentation/screens/add_post_screen.dart';
import 'package:notebin/features/post/presentation/screens/posts_screen.dart';
import 'package:notebin/features/profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    context.read<HomeCubit>().changeIndex(0) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(builder: (context, state) {
      return Scaffold(
        body: const [
          PostsScreen() ,
          AddPostScreen() ,
          ProfileScreen() ,
        ][state.index], //destination screen
        extendBody: true,
        appBar: AppBar(
          title: const Text("NOTEBIN"),
          centerTitle: true,
        ),
        bottomNavigationBar: FloatingNavbar(
          width: MediaQuery.of(context).size.width * 70/100,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: (int val) {
            context.read<HomeCubit>().changeIndex(val) ;
          },
          currentIndex: state.index,
          items: state.tabs.map((e) => FloatingNavbarItem(icon: e.iconData, title: e.label,)).toList()
        ),
      );
    }, listener: (context, state) {

    }) ;
  }
}
