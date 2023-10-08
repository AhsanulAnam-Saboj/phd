import 'package:flutter/material.dart';
import 'package:phd/Actions/CurrentUser.dart';
import 'package:phd/addittional/User.dart';
import 'package:phd/Actions/PostCreato.dart';

class ClickToPost extends StatefulWidget {
  final User currentUser;
  const ClickToPost({
    Key? key,
    required this.currentUser,
  }) : super(key: key);
  @override
  State<ClickToPost> createState() => _ClickToPostState();
}

class _ClickToPostState extends State<ClickToPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[100],
                  backgroundImage: AssetImage(currentUser.imageurl),
                ),
                SizedBox(
                  width: 10,
                ),

                  Expanded(

                    child: Material(
                      child: InkWell(
                        
                        overlayColor: MaterialStateProperty.all(Colors.grey[300]),
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostCreato(),
                            ),
                          );
                          setState(() {

                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                            ),

                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'What\'s your new medical update?',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                IconButton(onPressed: () {}, icon: Icon(Icons.photo,
                size: 30,)),
              ],
            ),
          ),
          const Divider(
            height: 10.0,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
