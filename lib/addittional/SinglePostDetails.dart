import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:phd/pages/Home.dart';

class SinglePostDetails {
  String HospitalName = '';
  String ConsultantName = '';
  String SinglePostText = '';
  String Expenditure = '';
  String Day = '';
  String Month = '';
  String Year = '';
  String Time = '';
  List<dynamic> itemList = [];

  Future pickFiles() async {
    final selectedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      //allowedExtensions: ['pdf','doc','docx','txt'],
    );
    if (selectedFiles != null) {
      var file;
      for (file in selectedFiles.files) {
        //File imageFile = File(file.path);
        itemList.add(file);
      }
    } else {
      return;
    }
  }

  Future getImageGallery() async {
    List<XFile>? _selectedPhoto = await ImagePicker().pickMultiImage();

    if (_selectedPhoto.length > 0) {
      var file;
      for (file in _selectedPhoto) {
        //File imageFile = File(file.path);
        itemList.add(file);
      }
    }
  }

  Future getImageCamera() async {
    XFile? _selectedPhoto =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (_selectedPhoto!.path.isNotEmpty) {
      File imageFile = File(_selectedPhoto.path);
      itemList.add(imageFile);
    }
  }

  Color getColor(String extension) {
    switch (extension) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'jpg':
      case 'png':
      case 'jpeg':
        return Colors.lightBlue;
      case 'txt':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  removeData() {
    singlePost.HospitalName = '';
    singlePost.ConsultantName = '';
    singlePost.SinglePostText = '';
    singlePost.Expenditure = '';
    singlePost.itemList.clear();
    singlePost.Day = '';
    singlePost.Month = '';
    singlePost.Year = '';
    singlePost.Time = '';
  }

  addSinglePost() {
    Posts aPost = Posts();
    aPost.SinglePostText = singlePost.SinglePostText;
    aPost.HospitalName = singlePost.HospitalName;
    aPost.ConsultantName = singlePost.ConsultantName;
    aPost.ConsultantName = singlePost.ConsultantName;
    aPost.Expenditure = singlePost.Expenditure;
    aPost.Day = singlePost.Day;
    aPost.Month = singlePost.Month;
    aPost.Year = singlePost.Year;
    aPost.Time = singlePost.Time;
    aPost.itemList.clear();
    aPost.itemList.addAll(singlePost.itemList);
    post.add(aPost);
  }

  addDateTime() {
    var time = DateTime.now();

    singlePost.Day = time.day.toString();
    singlePost.Month = time.month.toString();
    singlePost.Year = time.year.toString();

    print('${singlePost.Day} / ${singlePost.Month} / ${singlePost.Year}');
  }
}

SinglePostDetails singlePost = SinglePostDetails();
