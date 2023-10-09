import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phd/addittional/UserInfo.dart';

import '../Auth/loginpage.dart';
import '../pages/Appointment.dart';
import '../pages/Medicines.dart';
import 'Home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? userName = FirebaseAuth.instance.currentUser?.displayName;
  String? userImage = FirebaseAuth.instance.currentUser?.photoURL;

  int level = 0;
  File? image;
  UserInfoDetails profileImage = UserInfoDetails();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(12),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        color: Colors.white,
                        icon: const Icon(
                          Icons.rss_feed,
                          size: 25,
                        ),
                      ),
                      const Text(
                        'Feed',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()));
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.calendar_today, size: 25),
                      ),
                      const Text(
                        'Appointment',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Medicines()));
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.medical_services, size: 25),
                      ),
                      const Text(
                        'Medicines',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        },
                        color: Colors.white,
                        icon: const Icon(Icons.account_circle, size: 25),
                      ),
                      const Text(
                        'Account',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      PopupMenuButton(
                        icon: const Icon(Icons.menu, color: Colors.white, size: 25),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: const Text('Logout')
                          )
                        ],
                      ),
                      const Text('Menu', style: TextStyle(color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(children: [
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider("$userImage"),
                    backgroundColor: Colors.blueAccent,
                    radius: 40,
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      onPressed: () async {
                        //final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                        await profileImage.getImageUserImage();
                        //SharedPreferences photo = await SharedPreferences.getInstance();
                      },
                      child: const Text('Select Photo')),
                ]),
              ),
              Divider(
                height: 80,
                color: Colors.grey[800],
              ),
              Text(
                'Name',
                style: TextStyle(color: Colors.grey[700], letterSpacing: 1.0),
              ),
              const SizedBox(height: 10),
              Text(
                '$userName',
                style: TextStyle(
                  color: Colors.grey[800],
                  letterSpacing: 1.0,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'Your Problems',
                style: TextStyle(
                  color: Colors.grey[700],
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'A,B,C problems',
                style: TextStyle(
                  color: Colors.amberAccent[800],
                  letterSpacing: 1.0,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                'About',
                style: TextStyle(
                  color: Colors.grey[700],
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'A Competitive Programmer',
                style: TextStyle(
                  color: Colors.amberAccent[800],
                  letterSpacing: 1.0,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
