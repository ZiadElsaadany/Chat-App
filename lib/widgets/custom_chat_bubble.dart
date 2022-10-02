import 'package:flutter/material.dart';

import '../constants.dart';

class CustomChatBubble extends StatelessWidget {
   CustomChatBubble({Key? key ,required this.docs}) : super(key: key);
  String docs   ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
        padding: const EdgeInsets.only(left: 16,top: 32, bottom: 32,right: 32),
        decoration: const BoxDecoration(
            color: kPrimaryColor   ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
        ),
        child: Text( docs,style: const TextStyle(
          color: Colors.white,

        ),),
      ),
    );
  }
}
class CustomChatBubbleForFriend extends StatelessWidget {
  CustomChatBubbleForFriend({Key? key ,required this.docs}) : super(key: key);
  String docs   ;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16 , vertical: 10),
        padding: const EdgeInsets.only(left: 16,top: 32, bottom: 32,right: 32),
        decoration: const BoxDecoration(
            color: Color(0xff006D84)   ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )
        ),
        child: Text(
          docs ,
          style: const TextStyle(
          color: Colors.white,
        ),),

      ),
    );
  }
}

