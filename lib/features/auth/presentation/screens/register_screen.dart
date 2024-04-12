import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/utils/enums.dart';
import 'package:notebin/features/auth/domain/entities/register_entity.dart';
import 'package:notebin/features/auth/presentation/screens/login_screen.dart';
import 'package:notebin/features/home/presentation/screens/home_screen.dart';

import '../../../../core/utils/app_ui_helper.dart';
import '../../../../core/widgets/form/custom_text_form_field.dart';
import '../bloc/auth_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "armin@gmail.com");

  final passwordController = TextEditingController(text: "12345678");

  final passwordConfirmationController = TextEditingController(text: "12345678");

  final nameController = TextEditingController(text: "armin mehraein");

  void onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      RegisterEntity entity = RegisterEntity(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text);
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),

        body: Column(
    children: [
    Expanded(flex: 4,child: Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                blurRadius: 1,
                blurStyle: BlurStyle.solid,
                spreadRadius: 8
            ),
          ],
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(50))
      ),
      child: BlocConsumer<AuthCubit,AuthState>(builder: (context, state) {
        return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("NOTEBIN",style: TextStyle(fontSize: 30,color: Theme.of(context).cardColor,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 50),
                  CustomTextFormField(
                      icon: const Icon(Icons.title_rounded),
                      controller: nameController, label: "Name",validationType: FormValidationType.name),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    icon: const Icon(Icons.email_rounded),
                    controller: emailController, label: "Email",validationType: FormValidationType.email,),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                      icon: const Icon(Icons.lock_rounded),
                      controller: passwordController, label: "Password",validationType: FormValidationType.password),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                      icon: const Icon(Icons.lock_rounded),
                      controller: passwordConfirmationController,
                      label: "PasswordConfirmation",validationType: FormValidationType.password),

                ],
              ),
            )) ;
      }, listener: (context, state) {

        if(state is AuthMain && state.isRegister) {
          onRegister() ;
        }

        if(state is AuthMain && state.message != null) {
          showSnackBar(context: context, message: state.message!) ;
        }
      },))
    ),
      Expanded(flex: 2,child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: onFormSubmit,
              child: const Text("Sign up")),
          const SizedBox(height: 5),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: onChangePage,
            child: const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 2.5),
              child:  Text("Have an account? Login "),
            ),
          )
        ],
      )) ,

    ],
    ));


  }
}
