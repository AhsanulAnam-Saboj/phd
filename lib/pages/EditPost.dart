import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:phd/addittional/CustomColors.dart';
import 'package:phd/Actions/HospitalConsultant.dart';
import 'package:phd/addittional/SinglePostDetails.dart';

import 'Home.dart';

class EditPost extends StatefulWidget {
  Posts editedpost = Posts();
  int postid;
  EditPost( this.editedpost,this.postid);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
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
                style:  TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      post[widget.postid] = widget.editedpost as Posts;
                    });
                  //  postList[widget.postid] = widget.editedpost as Posts;
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/home');

                  },
                  child: const  Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ]),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  thickness: 0.5,
                ),
                Container(
                  height: 100,
                  child: TextField(
                    textAlign: TextAlign
                        .start, // Center aligns the hint text horizontally.
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    maxLines: null,
                    controller: usedText,
                    onChanged: (text) {
                      setState(() {
                        widget.editedpost.SinglePostText = text;
                      });
                    },

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What\'s your new medical update?',
                      hintStyle: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: Expanded(
                        child: GridView.builder(
                         // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount:  widget.editedpost.itemList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final itemName = widget.editedpost.itemList[index].name;
                            if ( widget.editedpost.itemList[index] is PlatformFile) {
                              final extenSion = widget.editedpost.itemList[index].extension ?? 'none';
                              final exColor = getColor(extenSion);
                              return GestureDetector(
                                onTap: (){
                                  OpenFile.open( widget.editedpost.itemList[index].path);
                                },
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      child: Container(

                                        color: exColor,
                                        child: Center(
                                          child: Text(
                                            '.$extenSion',
                                            style: TextStyle(
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: -10,
                                      top: -10,
                                      child: Container(
                                        child: IconButton(
                                          onPressed: () {
                                            singlePost.itemList.removeAt(index);
                                            setState(() {});
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,

                                      left: 2,
                                      child: Text(
                                        itemName,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            else if ( widget.editedpost.itemList[index] is
                            XFile) {
                              return GestureDetector(
                                onTap: (){
                                  OpenFile.open( widget.editedpost.itemList[index].path);
                                },
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(widget.editedpost.itemList[index].path),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      right: -10,
                                      top: -8,
                                      child: Container(
                                        child: IconButton(
                                          onPressed: () {
                                            widget.editedpost.itemList.removeAt(index);
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,

                                      left: 2,
                                      child: Text(
                                        itemName,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            else return null;

                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          await widget.editedpost.getImageGallery();

                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              color: Colors.grey[900],
                            ),
                            const SizedBox(
                                width:
                                8), // Optional space between the icon and text
                            Text(
                              'Photo/Video',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          await widget.editedpost.pickFiles();

                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.attachment,
                              color: Colors.grey[900],
                            ),
                            const SizedBox(
                                width:
                                8), // Optional space between the icon and text
                            Text(
                              'Documents',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          EnterHospitalName(context);
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.local_hospital,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                                width:
                                8), // Optional space between the icon and text
                            Text(
                              'Hospital Name',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          EnterConsultantName(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                                width:
                                8), // Optional s pace between the icon and text
                            Text(
                              'Consultant Name',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          await widget.editedpost.getImageCamera();
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                                width:
                                8), // Optional space between the icon and text
                            Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          EnterExpenditure(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.attach_money_rounded,
                              color: Colors.grey[900],
                            ),
                            SizedBox(
                                width:
                                8), // Optional space between the icon and text
                            Text(
                              'Expenditure / ব্যয়',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 0,
                      thickness: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
