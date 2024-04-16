import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:notebin/core/utils/enums.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({super.key, required this.controller, required this.label, this.maxLine, this.suffixText, this.validationType, this.icon, this.isDark = false});
  final TextEditingController controller ;
  final String label ;
  final int? maxLine ;
  final String? suffixText ;
  final Widget? icon ;
  final bool isDark ;
  final FormValidationType? validationType ;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine,
      validator: (value) {

        FormValidationType? type = widget.validationType ;

        if(value == null || value == "") {
          return "this field is required" ;
        }

        if(type == FormValidationType.email) {
          if(!EmailValidator.validate(value)) {
            return "entered email not valid" ;
          }
        }

        if(type == FormValidationType.name) {
          if(value.isNumeric()) {
            return "name must contain word" ;
          }
        }

        if(type == FormValidationType.password) {
          if(value.length < 8 ) {
            return "password must 8 length" ;
          }
        }

        return null ;
      },
      cursorColor: widget.isDark ? null : Theme.of(context).cardColor,
      controller: widget.controller,
      decoration:  InputDecoration(prefixIcon: widget.icon,
      suffixText: widget.suffixText,
        prefixIconColor: widget.isDark ? null: Theme.of(context).cardColor,
        label: Text(widget.label,style: TextStyle(color: widget.isDark ? null: Theme.of(context).cardColor)),
        border: OutlineInputBorder(
    borderSide:  BorderSide(color: widget.isDark ? Theme.of(context).primaryColor : Theme.of(context).cardColor),),
          focusedBorder: OutlineInputBorder(
    borderSide:  BorderSide(color:widget.isDark ? Theme.of(context).primaryColor:  Theme.of(context).cardColor),),
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: widget.isDark ? Theme.of(context).primaryColor: Theme.of(context).cardColor),
          ),
      ),
    );
  }
}
