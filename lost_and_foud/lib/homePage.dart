import 'dart:developer';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:lost_and_foud/addItem.dart';
import 'package:lost_and_foud/addLost.dart';
import 'package:lost_and_foud/dawer1.dart';
import 'package:lost_and_foud/drawer.dart';
import 'package:lost_and_foud/login.dart';
import 'package:lost_and_foud/registration.dart';
import 'package:lost_and_foud/search.dart';
import 'package:lost_and_foud/setting.dart';
import 'package:getwidget/getwidget.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

final List<List> imageList = [
  <String>[
    "https://res.cloudinary.com/blue-sky/image/upload/v1676667400/sample/i1_grd9fi.jpg",
    "Do you some wallets to keep your money safe",
    "Wallet for mens",
    "199 ETB"
  ],
  <String>[
    "https://res.cloudinary.com/blue-sky/image/upload/v1676668009/sample/i2_mgxt9t.jpg",
    "Do you some wallets to keep your money safe",
    "Mobile holder",
    "129 ETB"
  ],
  <String>[
    "https://res.cloudinary.com/blue-sky/image/upload/v1676668008/sample/i3_ipzluz.jpg",
    "Do you some wallets to keep your money safe",
    "Mobile safety",
    "149 ETB"
  ],
  <String>[
    "https://res.cloudinary.com/blue-sky/image/upload/v1676668008/sample/i5_ylrur9.png",
    "Do you some wallets to keep your money safe",
    "Car key holder",
    "399 ETB"
  ],
  <String>[
    "https://res.cloudinary.com/blue-sky/image/upload/v1676668008/sample/i4_fwtsgt.png",
    "Do you some wallets to keep your money safe",
    "House key holder",
    "99 ETB"
  ],
];

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int counter = 0;
  Future<void> _increament() async {}
  void showDrawer() {
    print('tapped on show drawer!');
    setState(() {
      _showDrawer = !_showDrawer;
    });
  }

  bool _showDrawer = false;

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchItem(),
                ));
          }
          break;
        case 1:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddItem(),
                ));
          }
          break;
        case 2:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyStatefulWidget(),
                ));
          }
          break;

        case 3:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoute1(),
                ));
          }
          break;
        case 4:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingRoute(),
                ));
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content:
        //         Text('Pop Screen Disabled. You cannot go to previous screen.'),
        //     backgroundColor: Colors.red,
        //   ),
        // );
        return false;
      },
      child: Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue, // Will work
        title: const Text('Lost and Found'),
      ),
      drawer: DrawerWidget(
        closeFunction: showDrawer,
      ),

      body: Center(
        child: GFCarousel(
          height: MediaQuery.of(context).size.height,
          autoPlay: true,
          items: imageList.map(
            (url) {
              return Container(
                margin: EdgeInsets.all(2.0),
                child: GFCard(
                  boxFit: BoxFit.cover,
                  titlePosition: GFPosition.start,
                  image: Image.network(
                    url[0],
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  showImage: true,
                  title: GFListTile(
                    titleText: url[2],
                    subTitleText: url[3],
                  ),
                  content: Text(url[1]),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFAvatar(
                        backgroundColor: GFColors.PRIMARY,
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.SECONDARY,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      GFAvatar(
                        backgroundColor: GFColors.SUCCESS,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            setState(() {
              index;
            });
          },
        ),

        //  Image.asset("assets/images/lastlogo.png")
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(219, 202, 202, 202),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add lost',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add found',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    ),);
  }
}
