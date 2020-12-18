import 'dart:math';

import 'package:flutter/material.dart';

class CustomDrawerListView extends PreferredSize {


    final double height;
    final String username;
    final String email;
    final String photo_url;

    CustomDrawerListView({
        this.username,
        this.email,
        this.photo_url,
        this.height = kToolbarHeight,
        // this.isHomePage,
    });


    @override
    Size get preferredSize => Size.fromHeight(height);

    @override
    Widget build(BuildContext context) {

        return Theme(
            data: Theme.of(context).copyWith(canvasColor: Color(0xFF81687f)),
            child: Drawer(
                child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,

                    children: <Widget>[
                        UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                                color: Color(0xFF573555),
                            ),
                            accountName: Text(
                                "" + username + "",
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                            ),
                            accountEmail: Text(
                                email,
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            currentAccountPicture: CircleAvatar(
                                backgroundColor: Colors.red,
                                backgroundImage: NetworkImage(photo_url),
                            ),
                        ),
                        ListTile(
                            title: Text(
                                'Edit Profile',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            onTap: () {

                               // Navigator.of(context).push(MaterialPageRoute(
                                //    builder: (context) => EditProfilePage()));
                            }),
                        ListTile(
                            title: Text(
                                'Terms and Conditions',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            onTap: () {}),
                        ListTile(
                            title: Text(
                                'Manage Notifications',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            onTap: () {}),
                        ListTile(
                            title: Text(
                                'About',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            onTap: () {}),
                        ListTile(
                            title: Text(
                                'Contact Us',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            onTap: () {}),
                        ListTile(
                            title: Text(
                                'Logout',
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                            onTap: () {
                                //  setLogOutStateInSharedPreference();

                              //  Navigator.of(context).pushReplacement(
                               //     MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}
