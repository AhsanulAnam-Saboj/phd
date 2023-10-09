import 'package:flutter/material.dart';
import 'package:phd/Actions/SinglePostDetails.dart';

TextEditingController usedText = TextEditingController();

Future<void> EnterHospitalName(BuildContext context) async {


  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter Hospital Name'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Type Here',
          ),
          controller: usedText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                singlePost.HospitalName  = usedText.text;
                usedText.clear();

              },
              child: Text('Ok',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900],
          ),))
        ],
      );
    },
  );

}
Future<void> EnterConsultantName(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Consultant Name'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Type Here',
          ),
          controller: usedText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                singlePost.ConsultantName= usedText.text;
                usedText.clear();
              },
              child: Text('Ok',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900],
          ),))
        ],
      );
    },
  );
}

Future<void> EnterExpenditure(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Enter Total Expenditure'),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Type Here',
          ),
          controller: usedText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                singlePost.Expenditure = usedText.text;
                usedText.clear();

              },
              child: Text('Ok',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900],
          ),))
        ],
      );
    },
  );
}
