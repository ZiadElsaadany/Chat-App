import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
   CustomTextFormField({Key? key,
    required this.errorText,
    required this.hintText,
    required this.onChange,
   required  this.checkObsecure
  }) : super(key: key);
final String errorText;
final String hintText ;
 Function(String) onChange;
  bool checkObsecure;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return    TextFormField(
      obscureText: widget.checkObsecure,
      style: TextStyle( color: Colors.white),
      onChanged: widget.onChange,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.white
              )
          ),
          hintText: widget.hintText,
          suffixIcon: widget.hintText =='Password'?  InkWell(
            onTap: ( ) {
             setState(() {
               widget.checkObsecure = !widget.checkObsecure ;
             });
            },
            child: const Icon(Icons.remove_red_eye_sharp
            , color: Colors.white,
            ),
          ) : null,
          labelText: widget.hintText,
          hintStyle: const TextStyle(
          color: Colors.white
      ),
        labelStyle:  const TextStyle(
            color: Colors.white
        ),
      ),
      validator: ( value) {
        if(value == null || value.isEmpty) {
          return widget.errorText ;
        }
        return null;
      } ,
    );
  }
}
