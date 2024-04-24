import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/utils/enums.dart';
import 'package:notebin/features/auth/domain/entities/register_entity.dart';

import '../../../../core/bloc/theme/theme_cubit.dart';


import '../../../../core/utils/app_ui_helper.dart';
import '../../../../core/widgets/form/custom_text_form_field.dart';
import '../../../../core/widgets/form/file_picker_form_field.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/auth_cubit.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();

  MultipartFile? postFile ;


  void onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      RegisterEntity entity = RegisterEntity(
          name: nameController.text,
          image: postFile,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: passwordController.text);
      context.read<AuthCubit>().register(entity,context);
    }
  }

  void onChangePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void onRegister() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
                          child: BlocConsumer<AuthCubit,AuthState>(builder: (context, state) {
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

                                      CustomFilePickerFormField(
                                          isRequired: false,
                                          label: "Image Profile",
                                          onChange: (file) async {
                                            var ext = file.name.split(".").last;
                                            MultipartFile multipartFile = file.isWeb
                                                ? MultipartFile.fromBytes(
                                                file.uInt8List as List<int>,
                                                filename: "image.$ext") : MultipartFile.fromFileSync(
                                              File(file.path!).path,
                                              filename: "image.$ext",
                                            );
                                            postFile = multipartFile ;
                                          }) ,
                                      const SizedBox(height: 15),
                                      CustomTextFormField(
                                          isDark: true,
                                          icon: const Icon(Icons.title_rounded),
                                          controller: nameController, label: "Name",validationType: FormValidationType.name),
                                      const SizedBox(height: 15),
                                      CustomTextFormField(
                                        isDark: true,
                                        icon: const Icon(Icons.email_rounded),
                                        controller: emailController, label: "Email",validationType: FormValidationType.email,),
                                      const SizedBox(height: 15),
                                      CustomTextFormField(
                                          isDark: true,
                                          icon: const Icon(Icons.lock_rounded),
                                          controller: passwordController, label: "Password",validationType: FormValidationType.password),

                                      const SizedBox(height: 30),
                                      ElevatedButton(
                                          onPressed: onFormSubmit,
                                          child: const Text("Sign up")),

                                    ],
                                  ),
                                )) ;
                          },
                            listener: (context, state) {

                              if(state is AuthMain && state.isRegister) {
                                onRegister() ;
                              }

                              if(state is AuthMain && state.message != null) {
                                showSnackBar(context: context, message: state.message!) ;
                              }
                            },)
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: onChangePage,
                    child:  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2.5),
                      child:  Text("Have an account? Login",
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
