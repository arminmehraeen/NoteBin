import 'package:flutter/cupertino.dart';

class TabItemModel {

  final int index ;
  final IconData iconData ;
  final String label ;

  const TabItemModel({
    required this.index,
    required this.iconData,
    required this.label,
  });
}