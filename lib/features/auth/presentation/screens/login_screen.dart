import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/bloc/theme/theme_cubit.dart';
import 'package:notebin/core/utils/app_ui_helper.dart';
import 'package:notebin/core/utils/enums.dart';
import 'package:notebin/core/widgets/form/custom_text_form_field.dart';
import 'package:notebin/features/auth/domain/entities/login_entity.dart';
import 'package:notebin/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:notebin/features/auth/presentation/screens/register_screen.dart';

import '../../../home/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      LoginEntity entity = LoginEntity(email: emailController.text, password: passwordController.text);
      context.read<AuthCubit>().login(entity, context);
    }
  }

  void onChangePage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
  }

  void onLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child:ListView(
                shrinkWrap: true,
                physics:const BouncingScrollPhysics(),
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                          width: double.infinity,
                          child: BlocConsumer<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return Form(
                                  key: _formKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                         Text(
                                          "NOTEBIN",
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: context.read<ThemeCubit>().state.themeMode == ThemeMode.dark ?  Colors.white : Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 50),
                                        CustomTextFormField(

                                            icon: const Icon(Icons.email_rounded),
                                            controller: emailController,
                                            isDark: true,
                                            label: "Email",
                                            validationType: FormValidationType.email),
                                        const SizedBox(height: 15),
                                        CustomTextFormField(
                                          isDark: true,
                                          icon: const Icon(Icons.lock_rounded),
                                          controller: passwordController,
                                          label: "Password",
                                          validationType: FormValidationType.password,
                                        ),
                                        const SizedBox(height: 30),
                                        ElevatedButton(
                                            onPressed: onFormSubmit, child: const Text("Login")),

                                      ],
                                    ),
                                  ));
                            },
                            listener: (context, state) {
                              if (state is AuthMain && state.isLogin) {
                                onLogin();
                              }

                              if (state is AuthMain && state.message != null) {
                                showSnackBar(context: context, message: state.message!);
                              }
                            },
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: onChangePage,
                    child:  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2.5),
                      child: Text("Don't have an account? Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
          ),
        ),
      );
  }
}
