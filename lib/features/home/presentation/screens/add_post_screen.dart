import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/widgets/form/file_picker_form_field.dart';
import 'package:notebin/features/home/presentation/bloc/home_bloc.dart';
import 'package:dio/dio.dart';
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
  MultipartFile? postFile ;

  void onFormSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<HomeBloc>().add(AddPost(context: context, title: titleController.text, body: bodyController.text,postFile: postFile));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Post"),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeBloc,HomeState>(builder: (context, state) {
        return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                      isDark: true ,
                      controller: titleController, label: "Title"),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                      isDark: true ,
                      controller: bodyController, label: "Body",maxLine: 6),
                  const SizedBox(height: 15),
                  CustomFilePickerFormField(
                      isRequired: false,
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
            ))  ;
      }, listener: (context, state) {
        if(state.addPost is ActionSuccess) {

          Navigator.pop(context) ;
          var snackBar = SnackBar(
            content: Text((state.addPost as ActionSuccess).data,),
          );
          context.read<HomeBloc>().add(HomeDataLoad());
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },)
    );
  }
}
