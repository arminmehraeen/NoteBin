import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:notebin/features/auth/presentation/screens/login_screen.dart';

import '../../../../core/utils/app_ui_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void onLogout () {
    context.read<AuthCubit>().logout() ;
    showLoadingDialog(context: context);
  }


  void onPosts () {
    context.read<AuthCubit>().logout() ;
    showLoadingDialog(context: context);
  }

  void onLogoutNavigator() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginScreen(),
        ), (route) => false,//if you want to disable back feature set to false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<AuthCubit,AuthState>(builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: onLogout, child: const Text("Logout")),
                  const SizedBox(width: 5,),
                  ElevatedButton(onPressed: onPosts, child: const Text("Posts")),
                ],
              );
            }, listener: (context, state) {
              if(state is AuthMain && state.isLogout) {
                onLogoutNavigator() ;
              }
            },)
          ],
        ),
      ),
    );
  }


}
