import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   const CustomButton({Key? key , required this.fun , required this.text}) : super(key: key);
  final VoidCallback fun ;
  final String text ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),), 
            padding: MaterialStateProperty.all(EdgeInsets.all(10))
          ),
          onPressed: fun ,
          child:  Text( text,style: const TextStyle(
              color: Colors.black ,
              fontSize: 20
          ),)
      ),
    );
  }
}
