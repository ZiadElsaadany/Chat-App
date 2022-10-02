import 'package:chat_app_with_tharwat/screens/chat_screens.dart';
import 'package:chat_app_with_tharwat/screens/login_screens.dart';
import 'package:chat_app_with_tharwat/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main( ) async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp()) ;
}
class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      routes: {
         LoginScreen.routeName: (ctx)=> LoginScreen( ),
         RegisterScreen.route_name:(ctx)=> RegisterScreen(),
        ChatScreen.routeName:(ctx)=> ChatScreen()

      } ,
      initialRoute: LoginScreen.routeName,
    );
  }
}