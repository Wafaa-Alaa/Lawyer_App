import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Json_data/List_rating.dart';
import '../Json_data/user_model.dart';
class All_Lawyers extends StatefulWidget {
  const All_Lawyers({super.key});

  @override
  State<All_Lawyers> createState() => _All_LawyersState();
}

class _All_LawyersState extends State<All_Lawyers> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<UserModel> userdata = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              userdata.add(UserModel.fromJson(snapshot.data!.docs[i]));
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(userdata.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 10,
                            blurRadius: 10,
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 10, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            // rating[index]['column'],
                            rating[index]['avatar'],
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(userdata[index].fullName,style:TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                ),),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 12,
                                      width: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('online',style:TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),),
                                  ],
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                );
              }),
            );
          }
          if (snapshot.hasError) {
            return Text('No data avaible right now');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
