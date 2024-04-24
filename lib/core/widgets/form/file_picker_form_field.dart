import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebin/core/bloc/theme/theme_cubit.dart';

import '../../models/result_information_model.dart';
import '../../services/file_picker_service.dart';
import '../../utils/app_ui_helper.dart';

class CustomFilePickerFormField extends StatefulWidget {
  const CustomFilePickerFormField(
      {Key? key, required this.onChange, this.initValue, this.maximumSize, this.isRequired = true, this.label})
      : super(key: key);
  final Function(ResultInformationModel file) onChange;
  final initValue;
  final String? label ;
  final int? maximumSize ;
  final bool isRequired;
  @override
  State<CustomFilePickerFormField> createState() => _FilePickerFormFieldState();
}

class _FilePickerFormFieldState extends State<CustomFilePickerFormField> {
  FilePickerService service = FilePickerService();
  String fileName = "The file is not selected";
  @override
  void initState() {
    if (widget.initValue != null) {
      fileName = widget.initValue!.split("/").last;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (String? v) {
        if (widget.isRequired && (v == null || v == "The file is not selected")) {
          return "This field is required";
        }
        return null;
      },
      initialValue: fileName,
      builder: (field) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: formWidgetDecoration(field.hasError,context),
                child: ListTile(
                  title: Text(widget.label ?? "Select file"),
                  isThreeLine: widget.maximumSize != null,
                  subtitle:Text("$fileName${widget.maximumSize != null ? "\n${"Allowed size for upload"}: ${widget.maximumSize!} ${"Megabyte"}" : ""}",
                  maxLines: widget.maximumSize != null ? 2 : 1),
                  trailing: ElevatedButton(onPressed: () async {
                    ResultInformationModel? information = await service.getFile(maximumSize: widget.maximumSize);
                    if (information != null) {
                      setState(() {
                        fileName = information.name;
                        field.didChange(fileName);
                        widget.onChange(information);
                      });
                    }
                  }, child: const Text("Select"))
                )),
            FormFieldErrorWidget(field: field)
          ],
        );
      },
    );
  }
}


class FormFieldErrorWidget extends StatelessWidget {
  const FormFieldErrorWidget({super.key, required this.field});
  final FormFieldState field ;
  @override
  Widget build(BuildContext context) {
    return
      field.hasError && field.errorText != null ?
      Padding(padding: const EdgeInsets.all(5),child:
      Text(field.errorText!,style: TextStyle(color: context.read<ThemeCubit>().state.themeMode == ThemeMode.dark ? Colors.red : Colors.white70))) :
      Container();
  }
}

