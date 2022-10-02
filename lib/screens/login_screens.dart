
import 'dart:io';

import 'package:chat_app_with_tharwat/screens/chat_screens.dart';
import 'package:chat_app_with_tharwat/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_feild.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);
   static var routeName = 'final Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   String email = '';

    String password = '';

    bool isLoading= false;

final GlobalKey<FormState>  _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        color: kPrimaryColor,
      progressIndicator: CircularProgressIndicator(
        color: Colors.white,
      ) ,
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
            child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  // const Spacer( flex: 1,) ,
                  Image.asset('assets/images/scholar.png'),
                  const Text(
                    'Chat App ',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Pacifico', fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  // const Spacer( ) ,
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 32),

                      ),
                    ],
                  ) ,
                  const SizedBox(height: 20,),
                   CustomTextFormField(
                     checkObsecure: false,
                    onChange: (value){
                      email = value;
                    } ,
                      errorText: 'Pls Enter a Email',
                      hintText: 'Email'
                  ),
                  const SizedBox(height: 15,),

                   CustomTextFormField(
                      checkObsecure: true,
                     onChange:(value){
                       password = value ;
                     }  ,
                     errorText: 'Pls Enter a Password',
                     hintText: 'Password',

                   ),
                  const SizedBox(height: 15,),

                  CustomButton(
                  fun: ( ) async{
                    if(_formKey.currentState!.validate() )  {
                      isLoading= true;
                      setState(() {});
                      try {
                      await login(context);
                      Navigator.pushNamed(context, ChatScreen.routeName, arguments:email );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                         showSnackBar(context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                         showSnackBar(context, 'Wrong password provided for that user.');
                        }
                       } on SocketException{
                        showSnackBar(context, 'no internet');

                      }

                       catch(e){
                        showSnackBar(context, 'Something went wrong, pls try again');
                      }

                    }
                    isLoading = false;
                    setState(() {});
                  },
                  text: 'Sign In'
              ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text( 'don\'t have an account?',style: TextStyle(
                        color: Colors.white  ,
                        fontSize: 18
                      ),) ,
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RegisterScreen.route_name);
                        },
                        child: const Text ( '  Sign Up',style: TextStyle(
                            color: Color(0xffC7EDE6) ,
                          fontSize: 18
                        ),),
                      )
                    ],
                  ),
                  // const Spacer( flex: 3,) ,
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login( context ) async {
     final credential =await  FirebaseAuth.instance
         .signInWithEmailAndPassword(
       email: email,
       password: password,) ;
   }


}
