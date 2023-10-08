import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String? usremail = FirebaseAuth.instance.currentUser!.email;

  Future<String> _uploadFileToFirebase(File file, String fileName, String fileType) async {
    Reference storageReference = FirebaseStorage.instance.ref().child('Post/$usremail/$fileType/$fileName');
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future getImageGallery() async {
    List<XFile>? selectedPhoto = await ImagePicker().pickMultiImage();
    for (var file in selectedPhoto) {
      File image = File(file.path);
      String imageUrl = await _uploadFileToFirebase(image, file.name, 'images');
      itemList.add(imageUrl);
    }
  }

  Future getImageCamera() async {
    XFile? selectedPhoto = await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedPhoto!.path.isNotEmpty) {
      File imageFile = File(selectedPhoto.path);
      String imageUrl = await _uploadFileToFirebase(imageFile, selectedPhoto.name, 'images');
      itemList.add(imageUrl);
    }
  }

  Future pickFiles() async {
    final selectedFiles = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (selectedFiles != null) {
      for (var file in selectedFiles.files) {
        File xFile = File(file.path!);
        String fileUrl = await _uploadFileToFirebase(xFile, file.name, 'files');
        itemList.add(fileUrl);
      }
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
