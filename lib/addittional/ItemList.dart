import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ItemList {
  List<dynamic> itemList = [];
  XFile? userImage;

  Future<void> pickFiles() async {
    final selectedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      //allowedExtensions: ['pdf','doc','docx','txt'],
    );
    if (selectedFiles != null) {
      itemList.addAll(selectedFiles.files);
    }
    else {
      return;
    }
  }


  Future<void> getImageGallery() async {
    XFile? _selectedPhoto =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_selectedPhoto!.path.isNotEmpty) {
      itemList.add(_selectedPhoto);
    }
  }

  Future<void> getImageCamera() async {
    final XFile? _selectedPhoto =
    await ImagePicker().pickImage(source: ImageSource.camera);

    if (_selectedPhoto!.path.isNotEmpty) {
      itemList.add(_selectedPhoto);
    }
  }

  Future<void> getImageUserImage() async {
    final XFile? _selectedPhoto =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_selectedPhoto!.path.isNotEmpty) {
      userImage = _selectedPhoto;
    }
  }
  
}