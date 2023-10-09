
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:phd/addittional/CurrentUser.dart';
import 'package:phd/a%20Main%20Pages/Account.dart';
import 'package:phd/pages/Appointment.dart';

import 'package:phd/pages/ClickTopost.dart';
import 'package:phd/pages/EditPost.dart';
import 'package:phd/pages/Medicines.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Auth/loginpage.dart';

String monthName(String m) {
  switch (m) {
    case '1':
      return 'Jan';
    case '2':
      return 'Feb';
    case '3':
      return 'Mar';
    case '4':
      return 'Apr';
    case '5':
      return 'May';
    case '6':
      return 'Jun';
    case '7':
      return 'July';
    case '8':
      return 'Aug';
    case '9':
      return 'Sep';
    case '10':
      return 'Oct';
    case '11':
      return 'Nov';
    case '12':
      return 'Dec';
    default:
      return '';
  }
}

class Posts {
  String HospitalName = '';
  String ConsultantName = '';
  String SinglePostText = '';
  String Expenditure = '';
  String Day = '';
  String Month = '';
  String Year = '';
  String Time = '';
  List<dynamic> itemList = [];
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

  Future pickFiles() async {
    final selectedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      //allowedExtensions: ['pdf','doc','docx','txt'],
    );
    if (selectedFiles != null) {
      itemList.addAll(selectedFiles.files);
    } else {
      return;
    }
  }

  Future getImageGallery() async {
    List<XFile?> selectedPhoto = await ImagePicker().pickMultiImage();

    if (selectedPhoto.isNotEmpty) {
      itemList.addAll(selectedPhoto);
    }
  }

  Future getImageCamera() async {
    final XFile? selectedPhotos = await ImagePicker().pickImage(source: ImageSource.camera);

    if (selectedPhotos!.path.isNotEmpty) {
      itemList.add(selectedPhotos);
    }
  }
}

List<Posts> post = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? usrEml = FirebaseAuth.instance.currentUser!.email;
  String? usrNme = FirebaseAuth.instance.currentUser!.displayName;

  String selectvalue = "Edit";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'PMHT',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            //resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey[100],
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                    backgroundColor: Colors.grey[900],
                    centerTitle: true,
                    title: const Row(children: [
                      Text('PMHT  ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
                    ]),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(50.0),
                      child: Center(
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          Column(children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                                },
                                color: Colors.white,
                                icon: const Icon(Icons.rss_feed, size: 25)),
                            const Text('Feed', style: TextStyle(color: Colors.white))
                          ]),
                          Column(children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Appointment()));
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.calendar_today, size: 25),
                            ),
                            const Text('Appointment', style: TextStyle(color: Colors.white))
                          ]),
                          Column(children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Medicines()));
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.medical_services, size: 25),
                            ),
                            const Text('Medicines', style: TextStyle(color: Colors.white))
                          ]),
                          Column(children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.account_circle, size: 25),
                            ),
                            const Text('Account', style: TextStyle(color: Colors.white))
                          ]),
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
                        ]),
                      ),
                    ),
                    actions: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.grey[800], shape: BoxShape.circle),
                              child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)))),
                    ]),
                SliverToBoxAdapter(child: ClickToPost(currentUser: currentUser)),
                SliverList(
                    delegate: SliverChildBuilderDelegate(childCount: 2, (context, index) {
                  if (index == 0) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(usrEml)
                          .collection('Post')
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data!.docs;

                          if (data.isEmpty) {
                            return const Center(child: Text('No Post'));
                          }
                          Posts post = Posts();

                          return ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              post.itemList = data["file list"];
                              post.SinglePostText = data["SinglePost txt"];
                              post.HospitalName = data["Hospital Name"];
                              post.ConsultantName = data["Consultant Name"];
                              post.Expenditure = data["Expenditure"];
                              post.Day = data["Day"];
                              post.Month = data["Month"];
                              post.Year = data["Year"];

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(usrNme!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[900])),
                                          const SizedBox(height: 6),
                                          Text('${post.Day} ${monthName(post.Month)} ${post.Year}',
                                              style: const TextStyle(overflow: TextOverflow.fade, fontSize: 12))
                                        ]),
                                        PopupMenuButton<String>(
                                          icon: const Icon(Icons.more_horiz_outlined),
                                          onSelected: (String newval) {
                                            setState(() {
                                              selectvalue = newval; // Update the selected value
                                            });
                                            if (selectvalue == 'Edit') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditPost(post, index),
                                                ),
                                              );
                                            } else if (selectvalue == 'Delete') {
                                              FirebaseFirestore.instance
                                                  .collection('Users')
                                                  .doc(usrEml)
                                                  .collection('Post')
                                                  .doc(data.id)
                                                  .delete();
                                            }
                                          },
                                          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                            // const PopupMenuItem<String>(
                                            //   value: 'Edit', // Unique value for "Edit Post"
                                            //   child: Text('Edit Post'),
                                            // ),
                                            const PopupMenuItem<String>(
                                              value: 'Delete', // Unique value for "Delete Post"
                                              child: Text('Delete Post'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 1, height: 10, color: Colors.grey[400]),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(post.SinglePostText, style: const TextStyle(fontSize: 16)),
                                    ),
                                    ///
                                    const SizedBox(height: 10),
                                    GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: post.itemList.length,
                                      itemBuilder: (context, ind) {
                                        print('${post.itemList[ind]} saboj');

                                        if(isImage(post.itemList[ind])==true) {
                                          return GestureDetector(
                                            onTap: () async {
                                              final url = post.itemList[ind];
                                              final uri = Uri.parse(url);


                                              if (await canLaunchUrl(uri)) {
                                                await LaunchMode.platformDefault;

                                              } else {
                                                // Handle the case where the URL cannot be launched.
                                                print(
                                                    'Could not launch URL: $url');
                                              }
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: post.itemList[ind],
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget: (context, url,
                                                  error) => Icon(Icons.error),
                                            ),
                                          );
                                        }
                                        else{

                                          return GestureDetector(

                                            onTap: () async{
                                              final url = post.itemList[ind];
                                              final uri = Uri.parse(url);

                                              if (await canLaunchUrl(uri)) {
                                              await LaunchMode.platformDefault;

                                              } else {
                                              // Handle the case where the URL cannot be launched.
                                              print(
                                              'Could not launch URL: $url');
                                              }
                                            },
                                            child: FileItem(
                                              fileUrl: post.itemList[ind],
                                              fileName: 'File ${ind + 1}',
                                            ),
                                          );
                                        }
                                        /*FileItem(
                                          fileUrl: post.itemList[ind],
                                          fileName: 'File ${ind + 1}',
                                        );*/

                                        /*if (post.itemList[ind]
                                            is PlatformFile) {
                                          final extenSion = post
                                                  .itemList[ind]
                                                  .extension ??
                                              'none';
                                          final exColor =
                                              post.getColor(extenSion);
                                          return GestureDetector(
                                            onTap: () {
                                              OpenFile.open(
                                                  post.itemList[ind].path);
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
                                                        style:
                                                            const TextStyle(
                                                                fontSize:
                                                                    25),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (post.itemList[ind]
                                            is XFile) {
                                          return GestureDetector(
                                            onTap: () {
                                              OpenFile.open(
                                                  post.itemList[ind].path);
                                            },
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.network(
                                                    post.itemList[ind])
                                                /*Image.file(
                                                  File(post
                                                      .itemList[ind].path),
                                                  fit: BoxFit.cover,
                                                ),*/
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Text(
                                              '$index - $ind : ${post.itemList[ind]}');
                                        }*/
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (post.ConsultantName != '')
                                          Text('Consultant Name : ${post.ConsultantName}',
                                              style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                                        if (post.HospitalName != '')
                                          Text('Hospital Name : ${post.HospitalName}',
                                              style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                                        if (post.Expenditure != '')
                                          Text('Total Expenditure : ${post.Expenditure} Tk',
                                              style: TextStyle(fontSize: 16, color: Colors.grey[900])),
                                        const Divider(color: Colors.black, thickness: 1),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const Text('Error');
                      },
                    );
                  }
                }))
              ],
            )),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String fileUrl;
  final String fileName;

  const FileItem({super.key, required this.fileUrl, required this.fileName});

  Future<void> _launchURL() async {
    if (await canLaunch(fileUrl)) {
      await launch(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchURL,
      child: Container(
        padding: const EdgeInsets.all(14.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black26,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            const Icon(Icons.file_download, color: Colors.white),
            const SizedBox(width: 10.0),
            Text(fileName, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

bool isImage(String url) {
  final lowercaseUrl = url.toLowerCase();
  print(lowercaseUrl);
  // Check if the URL contains any of the image extensions
  var ind;
  for(ind=0 ;ind <lowercaseUrl.length-4;ind++){
    if(lowercaseUrl[ind] == 'j' && lowercaseUrl[ind+1] == 'p' && lowercaseUrl[ind+2]=='g')return true;
    if(lowercaseUrl[ind] == 'j' && lowercaseUrl[ind+1] == 'p' && lowercaseUrl[ind+2]=='e' && lowercaseUrl[ind+2]=='g')return true;
    if(lowercaseUrl[ind] == 'p' && lowercaseUrl[ind+1] == 'n' && lowercaseUrl[ind+2]=='g')return true;
    if(lowercaseUrl[ind] == 'w' && lowercaseUrl[ind+1] == 'e' && lowercaseUrl[ind+2]=='b' && lowercaseUrl[ind+2]=='p')return true;
  }
  return false;
}
// bool isImage(String url) {
//   // Define a list of image file extensions you want to check for
//   final imageExtensions = ['.jpg', '.jpeg', '.png', '.webp'];
//
//   // Convert the URL to lowercase for case-insensitive matching
//   final lowercaseUrl = url.toLowerCase();
//
//   // Check if the URL contains any of the image extensions
//   return imageExtensions.any((extension) => lowercaseUrl.endsWith(extension));
// }