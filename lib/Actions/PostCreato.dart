import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:phd/addittional/CustomColors.dart';
import 'package:phd/Actions/HospitalConsultant.dart';
import 'package:phd/addittional/SinglePostDetails.dart';

class PostCreato extends StatefulWidget {
  const PostCreato({super.key});

  @override
  State<PostCreato> createState() => _PostCreatoState();
}

class _PostCreatoState extends State<PostCreato> {
  String? usremail = FirebaseAuth.instance.currentUser!.email;
  TextEditingController usedText = TextEditingController();

  /////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> _storeFileUrlsInFirestore(List<String> fileUrls, String s) async {
    FirebaseFirestore.instance.collection('Users').doc(usremail).collection('Post').add({
      "file list": fileUrls,
      "SinglePost txt": singlePost.SinglePostText,
      "Hospital Name": singlePost.HospitalName,
      "Consultant Name": singlePost.ConsultantName,
      "Expenditure": singlePost.Expenditure,
      "Day": singlePost.Day,
      "Month": singlePost.Month,
      "Year": singlePost.Year,
      'time': DateTime.now(),
    });
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.grey[900],
              title: const Text(
                'Create Update',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    singlePost.addDateTime();
                    singlePost.removeData();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ]),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Divider(height: 10, thickness: 0.5),
                SizedBox(
                    height: 60,
                    child: TextField(
                        textAlign: TextAlign.start, // Center aligns the hint text horizontally.
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        maxLines: null,
                        controller: usedText,
                        onChanged: (text) {
                          setState(() {
                            singlePost.SinglePostText = text;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'What\'s your new medical update?',
                            hintStyle:
                                TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 20),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0)))),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                  itemCount: singlePost.itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    //final item = singlePost.itemList[index];
                    /*
                        if (singlePost.itemList[index] is PlatformFile) {
                          //final extenSion =
                          //    singlePost.itemList[index].extension ?? 'none';
                          //final exColor = getColor(extenSion);
                          return GestureDetector(
                            onTap: () {
                              OpenFile.open(singlePost.itemList[index]);
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                /*Positioned(
                                  child: Container(
                                    //color: exColor,
                                    child: Center(
                                      child: Text(
                                        '.$extenSion',
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/
                                Positioned(
                                  left: 87,
                                  top: -10,
                                  child: IconButton(
                                    onPressed: () {
                                      singlePost.itemList.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  right: 5,
                                  left: 2,
                                  child: Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        */
                    //if (singlePost.itemList[index] is XFile) {}
                    return GestureDetector(
                      onTap: () {
                        OpenFile.open(singlePost.itemList[index]);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.file(
                            singlePost.itemList[index],
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 87,
                            top: -10,
                            child: IconButton(
                              onPressed: () {
                                singlePost.itemList.removeAt(index);
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                          /*Positioned(
                                top: 100,
                                right: 10,
                                left: 2,
                                child: Text(
                                  item,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),*/
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                const Divider(thickness: 1),
                SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          await singlePost.getImageGallery();
                          setState(() {});
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Icon(Icons.photo_library_outlined, color: Colors.grey[900]),
                          const SizedBox(width: 8),
                          Text('Photo/Video', style: TextStyle(fontSize: 16, color: Colors.grey[900]))
                        ]))),
                const Divider(height: 0, thickness: 1),
                SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          await singlePost.pickFiles();
                          setState(() {});
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Icon(Icons.attachment, color: Colors.grey[900]),
                          const SizedBox(width: 8),
                          Text('Documents', style: TextStyle(fontSize: 16, color: Colors.grey[900]))
                        ]))),
                const Divider(height: 0, thickness: 1),
                SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          EnterHospitalName(context);
                          setState(() {});
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Icon(Icons.local_hospital, color: Colors.grey[900]),
                          const SizedBox(width: 8),
                          Text('Hospital Name', style: TextStyle(fontSize: 16, color: Colors.grey[900]))
                        ]))),
                const Divider(height: 0, thickness: 1),
                SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () {
                          EnterConsultantName(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Icon(Icons.person, color: Colors.grey[900]),
                          const SizedBox(width: 8),
                          Text('Consultant Name', style: TextStyle(fontSize: 16, color: Colors.grey[900]))
                        ]))),
                const Divider(height: 0, thickness: 1),
                SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () async {
                          await singlePost.getImageCamera();
                          setState(() {});
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.grey[900],
                          ),
                          const SizedBox(width: 8),
                          Text('Camera', style: TextStyle(fontSize: 16, color: Colors.grey[900]))
                        ]))),
                const Divider(height: 0, thickness: 1),
                SizedBox(
                    height: 50,
                    child: TextButton(
                        onPressed: () {
                          EnterExpenditure(context);
                        },
                        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Icon(Icons.attach_money_rounded, color: Colors.grey[900]),
                          const SizedBox(width: 8),
                          Text('Expenditure / ব্যয়', style: TextStyle(fontSize: 16, color: Colors.grey[900]))
                        ]))),
                const Divider(height: 0, thickness: 1)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
