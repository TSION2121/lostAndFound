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
import 'package:lost_and_foud/homePage.dart';
import 'package:lost_and_foud/login.dart';
import 'package:lost_and_foud/registration.dart';
import 'package:lost_and_foud/search.dart';

class SettingRoute extends StatefulWidget {
  const SettingRoute({super.key});

  @override
  State<SettingRoute> createState() => _SettingRoute();
}

class _SettingRoute extends State<SettingRoute> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Lost and Found'),
      ),
      body: const Center(
        child: Text("Setting"),
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
            label: 'Add',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'chat',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: 4,
        selectedItemColor: Color.fromARGB(255, 255, 255, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
