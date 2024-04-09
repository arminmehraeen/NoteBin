import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/widgets/default_widget.dart';
import 'package:notebin/core/widgets/loading.dart';
import 'package:notebin/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:notebin/features/auth/presentation/screens/login_screen.dart';
import 'package:notebin/features/home/presentation/bloc/home_bloc.dart';
import 'package:notebin/features/home/presentation/screens/add_post_screen.dart';

import '../../../../core/utils/app_ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void onLogout() {
    context.read<AuthCubit>().logout(context);
  }

  void onAddPost() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen(),)) ;
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeDataLoad(context: context));
    super.initState();
  }

  void onLogoutNavigator() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginScreen(),
        ), (route) => false, //if you want to disable back feature set to false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          actions: [
            BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
              return IconButton(
                  onPressed: onLogout, icon: const Icon(Icons.logout));
            }, listener: (context, state) {
              if (state is AuthMain && state.isLogout) {
                onLogoutNavigator();
              }
            },)
          ],
          title: const Text("Home"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(

            backgroundColor: Theme.of(context).primaryColor,
            onPressed: onAddPost,child: const  Icon(Icons.add)),
        body: BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeDataLoading) {
            return const Center(child: Loading());
          }

          if (state is HomeDataLoaded) {
            List data = state.data;
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text("Creator : ${item['user_id']}\n${item['body']}"),
                    isThreeLine: true,
                  ),
                );
              },);
          }

          return const DefaultWidget();
        }, listener: (context, state) {

        },)
    );
  }


}
