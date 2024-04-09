import 'package:flutter/material.dart';
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
            child: Text("Loading ...")),
        content: SizedBox(
          width: 100,
          height: 50,
          child: Loading(),
        ),
      )
  );
}

