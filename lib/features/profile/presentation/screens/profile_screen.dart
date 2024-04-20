import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/bloc/theme/theme_cubit.dart';
import 'package:notebin/core/models/user_model.dart';
import 'package:notebin/core/widgets/user_profile_widget.dart';

import '../../../../core/models/action_status.dart';
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
    context.read<ProfileBloc>().add(LoadUserProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      builder: (context, state) {
        ActionStatus status = state.profile;

        if (status is ActionWait) {
          return const Center(child: Loading());
        }

        if (status is ActionError) {
          return const Center(child: Text("Error while get information"));
        }

        if (status is ActionSuccess) {
          UserModel userModel = status.data;
          return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        isThreeLine: true,
                        subtitle:
                            Text("${userModel.email}\n${userModel.created_at}"),
                        leading: UserProfileWidget(url: userModel.image),
                        title: Text(userModel.name),
                      ),
                    ),
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          context.read<ThemeCubit>().changeTheme();
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: const ListTile(
                          title: Text("Change Theme"),
                          leading: Icon(Icons.color_lens_outlined),
                          trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
                        ),
                      )),
                  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            context.read<AuthCubit>().logout(context);
                          },
                          child: BlocConsumer<AuthCubit,AuthState>(
                            builder: (context, state) {
                              return const ListTile(
                                  trailing: Icon(Icons.arrow_forward_ios_rounded,size: 12,),
                                  title: Text("Logout"),
                                  leading: Icon(Icons.logout));
                            },
                            listener: (context, state) {
                              if (state is AuthMain && state.isLogout) {
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.pushAndRemoveUntil<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          const LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                });
                              }
                            },
                          )))
                ],
              ));
        }

        return const DefaultWidget();
      },
      listener: (context, state) {},
    );
  }
}
