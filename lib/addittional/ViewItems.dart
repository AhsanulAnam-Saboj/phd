import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phd/a%20Main%20Pages/Home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';

class ViewItems extends StatefulWidget {
  final int index;

  const ViewItems({required this.index});

  @override
  State<ViewItems> createState() => _ViewItemsState();
}

class _ViewItemsState extends State<ViewItems> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: const Text('All the Photos & Files'),
          centerTitle: true,
        ),
        body: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 1,
          // ),
          itemCount: post[widget.index].itemList.length,
          itemBuilder: (context, ind) {
            if (post[widget.index].itemList[ind] is PlatformFile) {
              final extenSion =
                  post[widget.index].itemList[ind].extension ?? 'none';
              final exColor = post[widget.index].getColor(extenSion);
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      OpenFile.open( post[widget.index].itemList[ind].path);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        color: exColor,
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              const Icon(Icons.description,
                                size: 30,
                              ),
                              Expanded(
                                child: Text('${post[widget.index].itemList[ind].name}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 16,

                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ),
                              ),
                            ],
                          ),
                        )
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    thickness: 10,
                    color: Colors.grey[400],
                  )
                ],
              );
            } else if (post[widget.index].itemList[ind] is XFile) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      OpenFile.open( post[widget.index].itemList[ind].path);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 350,
                          child: Image.file(File(
                            post[widget.index].itemList[ind].path,
                          ))),
                    ),
                  ),
                  Divider(
                    height: 5,
                    thickness: 10,
                    color: Colors.grey[400],
                  )
                ],
              );
            } else {
              return const Text('No item to show');
            }
          },
        ),
      ),
    );
  }
}
