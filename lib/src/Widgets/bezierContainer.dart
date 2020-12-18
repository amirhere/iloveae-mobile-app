import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class IAppBar extends PreferredSize {
    //
    final Widget child;
    final double height;
    final Color color;
    IAppBar({
        @required this.child,
        this.color,
        this.height = kToolbarHeight,
    });
    @override
    Size get preferredSize => Size.fromHeight(height);
    @override
    Widget build(BuildContext context) {
        return Container(
            height: preferredSize.height,
            color: color ?? Colors.red,
            alignment: Alignment.center,
            child: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Padding(
                    padding: EdgeInsets.only(left:50),
                    child: Text(
                        'Registration Form',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                        ),
                    )
                ) ,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Color(0xFFFFFFFF),
                    onPressed: () => Navigator.pop(context, false),
                ),
            ),
        );
    }
}
