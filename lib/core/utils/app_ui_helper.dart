import 'package:flutter/material.dart';
import 'package:notebin/core/resources/data_state.dart';
import 'package:notebin/core/widgets/loading.dart';

IconData convertThemeStateToIcon(ThemeMode themeMode) {
  return themeMode == ThemeMode.light ? Icons.nightlight_round : Icons.sunny;
}

void showSnackBar({required BuildContext context,required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
  );
}

BoxDecoration formWidgetDecoration(bool hasError,BuildContext context) {
  return BoxDecoration(
    border: hasError ? Border.all(color: Colors.redAccent, width: 1) : Border.all(color: Theme.of(context).primaryColor, width: 1),

    borderRadius: const BorderRadius.all(Radius.circular(5)),
  );
}



void showLoadingDialog ({required BuildContext context}) {

  RoundedRectangleBorder customShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );

  AlertDialog roundedDialog = AlertDialog(
    shape: customShape,
    title: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Text("Please Wait")),
    content: const SizedBox(
      width: 100,
      height: 50,
      child: Loading(),
    ),
  );

  showDialog(

      context: context,

      barrierDismissible: false,
      builder: (_) =>  roundedDialog
  );
}

void dismissibleDialog ({required BuildContext context}) => Navigator.pop(context);

// Future<DataState<T>> dialogRequest<T>({required BuildContext context,required Function() request})async {
//   showLoadingDialog(context: context) ;
//   var data = await request() ;
//   dismissibleDialog(context: context) ;
//   return data ;
// }

