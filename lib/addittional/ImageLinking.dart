
import 'package:image_picker/image_picker.dart';

class ImageLinking {
  List<XFile> imageList = [];
  XFile? userImage;

  Future getImageGallery() async {
    XFile? _selectedPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_selectedPhoto!.path.isNotEmpty) {
      imageList.add(_selectedPhoto);
    }
    else {return null;}
  }

  Future getImageCamera() async {
    final XFile? _selectedPhoto =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (_selectedPhoto!.path.isNotEmpty) {
      imageList.add(_selectedPhoto);
    }
  }

  Future getImageUserImage() async {
    final XFile? _selectedPhoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_selectedPhoto!.path.isNotEmpty) {
      userImage = _selectedPhoto;
    }
  }
}
