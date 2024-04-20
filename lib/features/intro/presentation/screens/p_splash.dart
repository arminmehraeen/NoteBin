import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/features/auth/presentation/screens/login_screen.dart';
import 'package:notebin/features/home/presentation/screens/home_screen.dart';


import '../../../../core/widgets/loading.dart';
import '../../../post/presentation/screens/posts_screen.dart';
import '../cubit/intro_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<IntroCubit>().initCheck() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IntroCubit,IntroState>(
      listener: (context, state) {
        if(state is IntroOk) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => state.isLogin ? const HomeScreen() :  const LoginScreen())) ;
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  if(state is IntroLoading) const Loading(),

                  if(state is IntroNoConnection) ...[
                    const Text("No internet connection !"),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => context.read<IntroCubit>().initCheck(),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Check",style: TextStyle(color: Colors.red),),
                      ),
                    )
                  ]

                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }
}
