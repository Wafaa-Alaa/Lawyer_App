import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/Pages/Home_Page.dart';

import '../Json_data/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    // var email='bedo30176@gmail.com'
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Chat Lawyer',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              reverse: true,
                              controller: _controller,
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                return messageList[index].id == email
                                    ? ChatBuble(
                                        message: messageList[index],
                                      )
                                    : ChatBubleForFriend(
                                        message: messageList[index]);
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: controller,
                            onSubmitted: (data) {
                              messages.add({
                                'message': data,
                                'createdAt': DateTime.now(),
                                'id': email,
                              });
                              _controller.animateTo(
                                0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                              controller.clear();
                            },
                            cursorColor: Color(0xff8B5D49),
                            decoration: InputDecoration(
                              hintText: 'Type text',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              suffixIcon: Icon(
                                Icons.send,
                                color: Color(0xff8B5D49),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xff8B5D49),
                                    // color: Colors.white.withOpacity(0.05),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xff8B5D49),
                                    // color: Colors.white.withOpacity(0.05),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xff8B5D49),
                                    // color: Colors.white.withOpacity(0.05),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 12),
              child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'Chat Lawyer',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              reverse: true,
                              controller: _controller,
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                return messageList[index].id == email
                                    ? ChatBuble(
                                        message: messageList[index],
                                      )
                                    : ChatBubleForFriend(
                                        message: messageList[index]);
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: controller,
                            onSubmitted: (data) {
                              messages.add({
                                'message': data,
                                'createdAt': DateTime.now(),
                                'id': email,
                              });
                              _controller.animateTo(
                                0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                              controller.clear();
                            },
                            cursorColor: Color(0xff8B5D49),
                            decoration: InputDecoration(
                              hintText: 'Type text',
                              hintStyle: TextStyle(
                                color: Colors.grey.withOpacity(0.4),
                              ),
                              suffixIcon: Icon(
                                Icons.send,
                                color: Color(0xff8B5D49),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xff8B5D49),
                                    // color: Colors.white.withOpacity(0.05),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xff8B5D49),
                                    // color: Colors.white.withOpacity(0.05),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Color(0xff8B5D49),
                                    // color: Colors.white.withOpacity(0.05),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );
          }
        });
  }
}

class ChatBuble extends StatefulWidget {
  const ChatBuble({
    required this.message,
    super.key,
  });
  final Message message;

  @override
  State<ChatBuble> createState() => _ChatBubleState();
}

class _ChatBubleState extends State<ChatBuble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Color(0xff8B5D49),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )),
        // height: 65,
        child: Text(
          widget.message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatefulWidget {
  const ChatBubleForFriend({
    required this.message,
    super.key,
  });
  final Message message;

  @override
  State<ChatBubleForFriend> createState() => _ChatBubleForFriendState();
}

class _ChatBubleForFriendState extends State<ChatBubleForFriend> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Color(0xff66280E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )),
        // height: 65,
        child: Text(
          widget.message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
