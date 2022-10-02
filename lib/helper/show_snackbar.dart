import 'package:flutter/material.dart';

void  showSnackBar( context,message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
      ));
}