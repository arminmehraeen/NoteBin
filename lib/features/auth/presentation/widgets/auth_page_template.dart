import 'package:flutter/material.dart';

class AuthPageTemplate extends StatelessWidget {
  const AuthPageTemplate({super.key, required this.footerWidgets, required this.base});
  final List<Widget> footerWidgets ;
  final Widget base ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color:
                          Theme.of(context).primaryColor.withOpacity(0.7),
                          blurRadius: 1,
                          blurStyle: BlurStyle.solid,
                          spreadRadius: 8),
                    ],
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(50))),
                child: base
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: footerWidgets
              ),
            ),
          ],
        ));
  }
}
