import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lost_and_foud/login.dart';
import "package:velocity_x/velocity_x.dart";

Widget myDrawer(BuildContext context) {
  return GFDrawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        GFDrawerHeader(
         
          currentAccountPicture: GFAvatar(
            radius: 80.0,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                "https://res.cloudinary.com/blue-sky/image/upload/v1676741778/user_bqeteb.png"),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              'Samuel Noah'.text.start.lg.bold.white.make(),
              SizedBox(
                height: 10,
              ),
              'Samuel@21'.text.start.lg.bold.white.make(),
            ],
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: null,
        ),
        ListTile(
          title: Text('logout'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SimpleLoginScreen(),
                ));
          },
        ),
      ],
    ),
  );
}
