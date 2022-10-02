import 'package:chat_app_with_tharwat/constants.dart';
import 'package:chat_app_with_tharwat/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen({Key? key}) : super(key: key);
  static String routeName = 'chat';



  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController controller = TextEditingController();

  String message='';
  final scrollController = ScrollController( ); 

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments ;

    CollectionReference messages = firestore.collection(kMessagesCollections);
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(
          kCreatedAt ,
          descending: true
        ).snapshots(),
        builder: (context , snapshot ) {
      if(snapshot.hasData ) {
          List<Message> messagesList =[];
          for(int i = 0 ; i<snapshot.data!.docs.length ; i++ )  {
            messagesList.add(Message.fromJson( snapshot.data!.docs[i]));
          }
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png',width: 40,),
                  Text('Chat'),
                ],
              ),
              automaticallyImplyLeading: false,

            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (ctx,index) {
                      return messagesList[index].id == email ?
                      CustomChatBubble(
                      docs:messagesList[index].message
                      )  : CustomChatBubbleForFriend(docs: messagesList[index].message);
                    },
                    itemCount: messagesList.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                  child: TextFormField(
                    controller: controller,
                    onChanged: ( data) {
                        message = data ;
                          },
                    decoration: InputDecoration(
                      hintText: 'Send Message..',
                      suffixIcon: IconButton(
                        icon: Icon ( Icons.send )  , color: kPrimaryColor, onPressed: ( ){
        if( message.trim() !=''&&message.trim()!=null){
                        messages.add(
                            {
                              kMessage: message,
                              kCreatedAt :DateTime.now(),
                              'id': email
                            }
                        ).then((value) {
                          controller.clear();
                          scrollController.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.decelerate
                          );
                        });

    }
                        message='';
                      },),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: kPrimaryColor ,
                          width: 1,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black ,
                          width: 1,
                        ),
                      ),

                    ),
                  ),
                ),
              ],
            )
        ) ;
      }else {
        return Scaffold(body : Center(child: CircularProgressIndicator()));
      }
        } );
  }
}
