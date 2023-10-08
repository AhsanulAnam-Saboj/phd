import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoDetails {
  XFile? userImage;

  Future<void> getImageUserImage() async {
    final selectedPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (selectedPhoto!.path.isNotEmpty) {
      userImage = selectedPhoto;
      Reference storageReference =
          FirebaseStorage.instance.ref().child('Post/${selectedPhoto.path}');
      UploadTask uploadTask = storageReference.putFile(File(selectedPhoto.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);
    }
  }
}
