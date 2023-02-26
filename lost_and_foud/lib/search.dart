import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';

import 'package:camera/camera.dart';
import 'package:lost_and_foud/addItem.dart';
import 'package:lost_and_foud/addLost.dart';
import 'package:lost_and_foud/dawer1.dart';
import 'package:lost_and_foud/drawer.dart';
import 'package:lost_and_foud/homePage.dart';
import 'package:lost_and_foud/login.dart';
import 'package:lost_and_foud/registration.dart';
import 'package:lost_and_foud/setting.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({super.key});

  @override
  State<SearchItem> createState() => _SearchItem();
}

class _SearchItem extends State<SearchItem> {
  CollectionReference recipes =
      FirebaseFirestore.instance.collection('lost_items');
  var counter = 0;
  void _increamnet() {
    counter++;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _ref = FirebaseDatabase.instance.ref().child("lost_items");
  }

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

  void showDrawer() {
    print('tapped on show drawer!');
    setState(() {
      _showDrawer = !_showDrawer;
    });
  }

  bool _showDrawer = false;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: WillPopScope(
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
    child :Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: const Text('Lost items'),
            bottom: TabBar(
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Column(children: <Widget>[
                    Text('Mobile'),
                  ]),
                ),
                Tab(
                  child: Column(children: <Widget>[
                    Text('Keys'),
                  ]),
                ),
                Tab(
                  child: Column(children: <Widget>[
                    Text("Bag"),
                  ]),
                ),
                Tab(
                  child: Column(children: <Widget>[
                    Text('Documents'),
                  ]),
                ),
                Tab(
                  child: Column(children: <Widget>[
                    Text('money'),
                  ]),
                ),
                Tab(
                  child: Column(children: <Widget>[
                    Text('Other'),
                  ]),
                ),
              ],
              onTap: (index) {
                _increamnet();
              },
            ),
          ),
          drawer: DrawerWidget(
            closeFunction: showDrawer,
          ),
          body: TabBarView(children: <Widget>[
            for (var i = 0; i < 6; i++) ...[
              FutureBuilder<QuerySnapshot>(
                  // <2> Pass `Future<QuerySnapshot>` to future

                  future: i == 0
                      ? FirebaseFirestore.instance
                          .collection('lost_items')
                          .where('type', isEqualTo: 'Mobile')
                          .get()
                      : i == 1
                          ? FirebaseFirestore.instance
                              .collection('lost_items')
                              .where('type', isEqualTo: 'Keys')
                              .get()
                          : i == 2
                              ? FirebaseFirestore.instance
                                  .collection('lost_items')
                                  .where('type', isEqualTo: 'Bag')
                                  .get()
                              : i == 3
                                  ? FirebaseFirestore.instance
                                      .collection('lost_items')
                                      .where('type', isEqualTo: 'Documents')
                                      .get()
                                  : i == 4
                                      ? FirebaseFirestore.instance
                                          .collection('lost_items')
                                          .where('type', isEqualTo: 'money')
                                          .get()
                                      : FirebaseFirestore.instance
                                          .collection('lost_items')
                                          .where('type', isEqualTo: 'Other')
                                          .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // <3> Retrieve `List<DocumentSnapshot>` from snapshot
                      final List<DocumentSnapshot> documents =
                          snapshot.data!.docs;
                      return ListView(
                          children: documents
                              .map((doc) => Column(
                                    children: [
                                      Card(
                                          shadowColor: Colors.black26,
                                          elevation: 20,
                                          margin: EdgeInsets.fromLTRB(
                                              10, 30, 10, 10),
                                          child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                        children: <Widget>[
                                                          Image.network(
                                                            // "https://res.cloudinary.com/blue-sky/image/upload/v1676667400/sample/i1_grd9fi.jpg",
                                                            doc['imag_url'],
                                                            // height: 100,
                                                            width: 150,
                                                            height: 160,
                                                            fit: BoxFit.contain,
                                                          )
                                                        ]),
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            "${doc['item']}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),

                                                          doc['lost']? GFButton(
                                                                onPressed: (){},
                                                                text: "lost",
                                                                shape: GFButtonShape.pills,
                                                                size: 20,
                                                                color: Colors.yellow,
                                                                padding:EdgeInsets.fromLTRB(0, 0, 0, 0),

                                                              ):GFButton(
                                                            onPressed: (){},
                                                            text: "found",
                                                            shape: GFButtonShape.pills,
                                                            size: 20,
                                                            color: Colors.green,
                                                            padding:EdgeInsets.fromLTRB(0, 0, 0, 0),

                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            "${doc['description']},",
                                                            style: TextStyle(
                                                                height: 1.2,
                                                                fontSize: 16),
                                                          ))
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            "phone  ${doc['phone']},",
                                                            style: TextStyle(
                                                                height: 1.2,
                                                                fontSize: 16),
                                                          ))
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: const [
                                                          Expanded(
                                                              child: Text(
                                                                  "posted by ")),
                                                          Expanded(
                                                              child: Text(
                                                            "samuel noah",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                          ))
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      TextButton(
                                                        onPressed: () {},
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Track item",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(width: 10),
                                                            Icon(
                                                                Icons
                                                                    .location_on,
                                                                color:
                                                                    Colors.red)
                                                          ],
                                                        ),
                                                       
                                                      ),
                                                    ],
                                                  ))

                                                  // ignore: unnecessary_new
                                                ],
                                              ))),
                                    ],
                                  ))
                              .toList());
                    } else if (snapshot.hasError) {
                      return Text('It${Error}!');
                    }
                    return Text("");
                  })

              // FirebaseAnimatedList(
              //   query: _ref,
              //   itemBuilder: (BuildContext context, DataSnapshot snapshot,
              //       animation, int index) {
              //     // Map lost_items2 = snapshot.value;
              //     var lost_items =
              //         Map<dynamic, dynamic>.from(snapshot.value! as Map);
              //     print(lost_items.length);

              //   },
              // ),
            ]
          ]),
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
            currentIndex: 0,
            selectedItemColor: Color.fromARGB(255, 255, 255, 255),
            onTap: _onItemTapped,
          ),
        )),);
  }
}
