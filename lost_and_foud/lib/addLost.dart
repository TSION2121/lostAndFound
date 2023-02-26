import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:lost_and_foud/homePage.dart';
import 'package:lost_and_foud/login.dart';
import 'package:lost_and_foud/registration.dart';
import 'package:lost_and_foud/search.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lost_and_foud/setting.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:geolocator/geolocator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoute1 extends StatefulWidget {
  const ChatRoute1({super.key});

  @override
  State<ChatRoute1> createState() => _ChatRoute1();
}

const List<String> list = <String>[
  'Mobile',
  'Bag',
  'Money',
  'Documents',
  'keys',
  'Other',
];

enum FileSource {
  path,
  bytes,
}

class _ChatRoute1 extends State<ChatRoute1> {
  late String selected;

  /// This three params can be obtained directly from your Cloudinary account Dashboard.
  /// The .signedConfig(...) factory constructor is recommended only for server side apps, where [apiKey] and
  /// [apiSecret] are secure.
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "188655986618161",
    apiSecret: "NhcWeFvdk1zcsO3QqpuzOHl5aCA",
    cloudName: "blue-sky",
  );
  final DatabaseReference reference =
  FirebaseDatabase.instance.reference().child('lost_items');

  String dropdownValue = list.first;
  String holder = '';
  String name = '';
  String phone = '';
  String description = '';
  String loactionText = "set current location";
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;
  bool imagepicked = false;
  bool isPicked = false;
  bool saveingLocation = false;
  late Position _currentPosition;
  void showDrawer() {
    print('tapped on show drawer!');
    setState(() {
      _showDrawer = !_showDrawer;
    });
  }

  bool _showDrawer = false;
  // List of items in our dropdown menu
  void _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = image;
      print(pickedImage);
      String file = pickedImage!.path;
      print(file);
      Image.file(File(pickedImage!.path));
      imagepicked = true;
    });
  }

  void _submit() async {
    final DatabaseReference reference =
    FirebaseDatabase.instance.ref().child('lost_items');

    print(name);
    print(description);
    print(dropdownValue);

    List<int> imageBytes = await pickedImage!.readAsBytes();
    final response = await cloudinary.upload(
        file: pickedImage!.path,
        fileBytes: imageBytes,
        resourceType: CloudinaryResourceType.image,
        folder: "sample",
        fileName: 'flutter',
        progressCallback: (count, total) {});

    if (response.isSuccessful) {
      print('Get your image from with ${response.secureUrl}');
      String? newkey = reference.push().key; // That is your unique key!
      String? url = response.secureUrl;
      // await reference.child(newkey!).set({
      //   "address": {
      //     "log": _currentPosition.longitude,
      //     "lat": _currentPosition.latitude
      //   },
      //   "description": description,
      //   "imag_url": url,
      //   "item": name,
      //   "poster_id": "ACMLSCNALN",
      //   "type": dropdownValue
      // });
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference lost_items =
      FirebaseFirestore.instance.collection('lost_items');
      lost_items.add({
        "address": {"log": 8.885112393178979, "lat": 38.80960319425162},
        "description": description,
        'phone': phone,
        "imag_url": url,
        "item": name,
        "poster_id": "ACMLSCNALN",
        "type": dropdownValue,
         "lost":true
      });
    }
  }

  _getCurrentLocation() async {
    await Geolocator.requestPermission();

    // await Geolocator.getCurrentPosition(
    //         desiredAccuracy: LocationAccuracy.best,
    //         forceAndroidLocationManager: true)
    //     .then((Position position) {
    setState(() {
      //     _currentPosition = position;
      loactionText = "location saved.";
      saveingLocation = false;
    });
    // }).catchError((e) {
    //   print(e);
    //   setState(() {
    //     loactionText = " open your location / try again";
    //   });
    // });
    print("position");
    saveingLocation = false;
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

  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  @override
  void initState() {
    super.initState();
    selected = "";
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
    child :Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add lost item'),
      ),
      drawer: DrawerWidget(
        closeFunction: showDrawer,
      ),
      
      body: SingleChildScrollView(
        
        child: Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(),
          child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 20, 0),
                        child: 'Item type'.text.start.lg.bold.make()),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DropdownButtonHideUnderline(
                      child: GFDropdown(
                        padding: const EdgeInsets.all(15),
                        borderRadius: BorderRadius.circular(5),
                        focusColor: Colors.blue,
                        border: const BorderSide(color: Colors.black12, width: 1),
                        dropdownButtonColor: Colors.white,
                        value: dropdownValue,
                        onChanged: (value) {
                          setState(() {
                            if (value == "Mobile") {
                              dropdownValue = "Mobile";
                            } else if (value == "keys") {
                              dropdownValue = "keys";
                            } else if (value == "Bag") {
                              dropdownValue = "Bag";
                            } else if (value == "Documents") {
                              dropdownValue = "Documents";
                            } else if (value == "Money") {
                              dropdownValue = "Money";
                            } else if (value == "Other") {
                              dropdownValue = "Other";
                            }
                          });
                        },
                        items: list
                            .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                        child: 'Item Name'.text.start.lg.bold.make()),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                      child: TextField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter item name',
                              border: OutlineInputBorder(),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.blue))))),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                        child: 'Your phone number'.text.start.lg.bold.make()),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                      child: TextField(
                          onChanged: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter phone number',
                              border: OutlineInputBorder(),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.blue))))),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                        child: 'Description'.text.start.lg.bold.make()),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(23, 0, 20, 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      // controller: textarea,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText: "I found this item ...",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 1, color: Colors.blue))),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                        child: GFButton(
                          onPressed: () {
                            _getCurrentLocation();
                            setState(() {
                              loactionText = "saving  location...";
                            });
                          },
                          // text: loactionText,
                          child: saveingLocation
                              ? LoadingAnimationWidget.inkDrop(
                            color: Colors.white,
                            size: 20,
                          )
                              : Text(loactionText),
                          shape: GFButtonShape.pills,
                        )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 20, 10),
                        child: 'picture'.text.start.lg.bold.make()),
                  ),
                  if (imagepicked)
                    Image.file(
                      File(pickedImage!.path),
                      height: MediaQuery.of(context).size.width * 0.65,
                      width: MediaQuery.of(context).size.width * 0.75,
                      scale: 0.7,
                      fit: BoxFit.cover,
                    ),
                  SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(23, 5, 20, 10),
                        child: imagepicked
                            ? GestureDetector(
                          onTap: () {
                            _takePicture();
                          },
                          child:
                          'change'.text.start.xl.blue600.underline.make(),
                        )
                            : IconButton(
                          iconSize: 50,
                          color: Colors.blue,
                          onPressed: () {
                            _takePicture();
                          },
                          icon: Icon(
                            Icons.photo_camera,
                          ),
                        ),
                      )),
                  GFButton(
                    onPressed: () {
                      _submit();
                    },
                    // text: loactionText,
                    child: Text("submit"),
                    shape: GFButtonShape.standard,
                  )
                ],
              )),
        ),
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
        currentIndex: 3,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    ),);
  }
}
