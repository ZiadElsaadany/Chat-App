
import 'package:chat_app_with_tharwat/screens/chat_screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../helper/show_snackbar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_feild.dart';

class RegisterScreen extends StatefulWidget {
   const RegisterScreen({Key? key}) : super(key: key);
   static String route_name = 'register' ;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   String  email= '' ;

   String  password= '' ;

   bool isLoading =false;

 final GlobalKey<FormState>  _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                  // const Spacer( flex: 1,) ,
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset('assets/images/scholar.png'),
                  const Text(
                    'Chat App ',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Pacifico', fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Sign Up',
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
                     onChange: (value){
                       password =value;
                     },
                      errorText: 'Pls Enter a Password',
                      hintText: 'Password'
                  ),
                  const SizedBox(height: 15,),

                  CustomButton(
                      fun: ( )async {
                        if (_formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await register(context);
                            Navigator.pushNamed(context, ChatScreen.routeName,arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                             showSnackBar(context, 'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                             showSnackBar(context, 'The account already exists for that email.');
                            }
                          } catch (e) {
                         showSnackBar(context, 'Something went wrong, Pls try again');
                          }
                          isLoading = false;
                          setState(() {});
                        }
                      },
                      text: 'Sign Up'
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const Text( 'already have an account? ',style: TextStyle(
                          color: Colors.white  ,
                          fontSize: 18
                      ),) ,
                      GestureDetector
                        (
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Text ( '  Sign In',style: TextStyle(
                            color: Color(0xffC7EDE6) ,
                            fontSize: 18
                        ),),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),

                ],
              ),
            ),
          ),
        ),

      ),
    );

  }

   Future<void> register( context ) async {
     final credential = await FirebaseAuth.instance
         .createUserWithEmailAndPassword(
       email: email,
       password: password,
     ) ;
   }

}
