import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/models/user_model.dart';
import 'package:notebin/core/widgets/user_profile_widget.dart';
import 'package:notebin/features/home/presentation/cubit/home_cubit.dart';

import '../../../../core/models/action_status.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/default_widget.dart';
import '../../../../core/widgets/loading.dart';
import '../../../auth/presentation/bloc/auth_cubit.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadUserProfile()) ;
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ProfileBloc,ProfileState>(builder: (context, state) {

        ActionStatus status = state.profile;

        if (status is ActionWait) {
          return const Center(child: Loading());
        }

        if(status is ActionError) {
          return const Center(child: Text("Error while get information"));
        }

        if(status is ActionSuccess) {
          UserModel userModel = status.data;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                UserProfileWidget(url: userModel.image,size: 50,),


                const SizedBox(height: 20,),
                Text(userModel.name) ,
                const SizedBox(height: 10,),
                Text(userModel.email) ,
                const SizedBox(height: 20,),
                BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
                  return IconButton(onPressed: () {
                    context.read<AuthCubit>().logout(context);
                  }, icon: const Icon(Icons.logout));
                }, listener: (context, state) {
                  if (state is AuthMain && state.isLogout) {

                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => const LoginScreen(),
                        ), (route) => false,
                      );
                    });
                  }
                },)
              ],
            ),
          );
        }

        return const DefaultWidget();

      }, listener: (context, state) {

      },);


  }
}


