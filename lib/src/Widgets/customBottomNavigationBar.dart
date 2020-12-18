import 'dart:math';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends PreferredSize {
  final double height;

  CustomBottomNavigationBar({
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 30,
      color: Theme.of(context).primaryColor,
    );
  }
}
