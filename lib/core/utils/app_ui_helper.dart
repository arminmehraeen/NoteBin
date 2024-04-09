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


void showLoadingDialog ({required BuildContext context}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>  AlertDialog(
        title: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text("Loading ...")),
        content: const SizedBox(
          width: 100,
          height: 50,
          child: Loading(),
        ),
      )
  );
}

void dismissibleDialog ({required BuildContext context}) => Navigator.pop(context);

// Future<DataState<T>> dialogRequest<T>({required BuildContext context,required Function() request})async {
//   showLoadingDialog(context: context) ;
//   var data = await request() ;
//   dismissibleDialog(context: context) ;
//   return data ;
// }

