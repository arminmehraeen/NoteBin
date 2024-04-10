import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/features/home/presentation/bloc/home_bloc.dart';

import '../../../../core/widgets/form/custom_text_form_field.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {


  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<HomeBloc>().add(AddPost(context: context, title: titleController.text, body: bodyController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                    controller: titleController, label: "Title"),
                const SizedBox(height: 15),
                CustomTextFormField(
                  controller: bodyController, label: "Body",maxLine: 6),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: onFormSubmit,
                        child: const Text("Submit")),
                  ],
                )
              ],
            ),
          )) ,
    );
  }
}
