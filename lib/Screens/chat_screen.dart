import 'package:chat_app/components/Const.dart';
import 'package:chat_app/components/component.dart';
import 'package:chat_app/models/Message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatScreen extends StatelessWidget {
  var sendMessageControler = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(messagesCollections);

  String? email;
  chatScreen({required this.email});

  final scrollControler = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('TimeOfSend', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            print(email);
          }
          // print(snapshot.data!.docs[0]['Messages']);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Logo,
                    height: 70,
                  ),
                  Text('Chat'),
                ],
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollControler,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? BubleChat(message: messagesList[index])
                            : BubleChatRe(message: messagesList[index]);
                      },
                      itemCount: messagesList.length,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    child: defultTextField(
                        hintText: 'Send Messages...',
                        textColor: Colors.grey,
                        onSumbitted: (value) {
                          messages.add({
                            'Messages': value,
                            'TimeOfSend': DateTime.now(),
                            'id': email
                          });
                          sendMessageControler.clear();

                          scrollControler.animateTo(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        controler: sendMessageControler,
                        color: Colors.black,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            child: IconButton(
                              onPressed: () {
                                addMessages();
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                sendMessageControler.clear();
                                scrollControler.animateTo(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              icon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> addMessages() {
    return messages
        .add({
          'Messages': sendMessageControler.text,
          'TimeOfSend': DateTime.now(),
          'id': email
        })
        .then((value) => print("User Added and value is"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
