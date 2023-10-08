import 'package:flutter/material.dart';
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
      return Colors.lightBlueAccent;
    case 'mp4':
    case 'mov':
    case 'mkv':
      return Colors.amber;

    case 'txt':
      return Colors.green;
    default:
      return Colors.grey;
  }
}