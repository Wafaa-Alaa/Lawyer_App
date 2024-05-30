import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/Json_data/List_Statement.dart';
import 'package:project/Json_data/List_rating.dart';
import 'package:project/Pages/Edit_Profile.dart';
import 'package:project/Pages/HomePage_2.dart';
import 'package:project/Pages/SignUp_Page.dart';

import '../Json_data/List_account_name.dart';
import '../Json_data/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> key = GlobalKey();

  List<QueryDocumentSnapshot> data = [];
  
  //final currentUser = FirebaseAuth.instance.currentUser!;
User? currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool isLoading=false;
  @override
  void initState() {
    super.initState();
  }
 Future<void> getCurrentUser() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;
    } catch (e) {
      // Handle the error if unable to get the current user
      print('Error getting current user: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.where('uid', isEqualTo: currentUser?.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<UserModel> userdata = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              userdata.add(UserModel.fromJson(snapshot.data!.docs[i]));
            }
            return Padding(
              padding: const EdgeInsets.only(
                  top: 70, right: 20, left: 20, bottom: 8),
              child: Scaffold(
                key: key,
                drawer: Drawer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 70, right: 20, left: 20, bottom: 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                             /* GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'EditProfile');
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff3A4859),
                                    ),
                                    /* Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1.6,
                                  color: Colors.white,
                                )
                            ),
                            child: Icon(Icons.person,size: 35,color: Colors.white,
                            ),
                          ),
                        )*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                              width: 1.6,
                                              color: Colors.white,
                                            )),
                                        child: Icon(
                                          Icons.person,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ) /*Obx(()=>authController.myUser.value.image==null?Center(child: CircularProgressIndicator())
                         :Image(image:NetworkImage(authController.myUser.value.image!),fit: BoxFit.fill)),*/
                                    ),
                              ),*/
                              CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(userdata[0].image),
                            ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                userdata[0].email,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff3A4859),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign Out',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () async {
                                      GoogleSignIn googleSignIn =
                                          GoogleSignIn();
                                      googleSignIn.disconnect();
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Homepage_2()));
                                    },
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edit Profile',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditProfile()));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              children: List.generate(account.length, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                account[index]['title'],
                                SizedBox(
                                  height: 30,
                                ),
                                account[index]['icon'],
                              ],
                            );
                          })),
                        ]),
                  ),
                ),
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      key.currentState!.openDrawer();
                    },
                      child: CircleAvatar(
                                radius: 30,
                                backgroundImage:NetworkImage(userdata[0].image,)
                              ),
                    ),/*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff3A4859),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                width: 1.6,
                                color: Colors.white,
                              )),
                          child: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                        //Image(image:NetworkImage(authController.myUser.value.image!),fit: BoxFit.fill,))
                      ),
                    ),
                  ),*/
                  title: Text(
                    userdata[0].email,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xff3A4859),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications_none,
                      size: 30,
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 13, bottom: 16),
                          child: Text(
                            'What do you think ?',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'About us !',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children:
                                  List.generate(statement.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: 95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: statement[index]['color'],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: statement[index]['title'],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    statement[index]['image']
                                  ],
                                ),
                              ),
                            );
                          }))),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Best rating ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(rating.length, (index) {
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
                                      rating[index]['column'],
                                    ]),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('No data avaible right now');
          } else {
            return SignUp_Page();
            Center(child: CircularProgressIndicator());
          }
        });

    /*Padding(
      padding: const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 8),
      child: Scaffold(
        key: key,
        drawer: Drawer(
          child: Padding(
            padding: EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'EditProfile');
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xff3A4859),
                            ),
                            /* Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1.6,
                                  color: Colors.white,
                                )
                            ),
                            child: Icon(Icons.person,size: 35,color: Colors.white,
                            ),
                          ),
                        )*/
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                      width: 1.6,
                                      color: Colors.white,
                                    )),
                                child: Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ) /*Obx(()=>authController.myUser.value.image==null?Center(child: CircularProgressIndicator())
                         :Image(image:NetworkImage(authController.myUser.value.image!),fit: BoxFit.fill)),*/
                            ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Wafaa',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xff3A4859),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sign Out',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: IconButton(
                            onPressed: () async {
                              GoogleSignIn googleSignIn = GoogleSignIn();
                              googleSignIn.disconnect();
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Homepage_2()));
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => EditProfile()));
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                      children: List.generate(account.length, (index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        account[index]['title'],
                        SizedBox(
                          height: 30,
                        ),
                        account[index]['icon'],
                      ],
                    );
                  })),
                ]),
          ),
        ),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              key.currentState!.openDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff3A4859),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        width: 1.6,
                        color: Colors.white,
                      )),
                  child: Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                //Image(image:NetworkImage(authController.myUser.value.image!),fit: BoxFit.fill,))
              ),
            ),
          ),
          title: Text(
            'wafaa',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xff3A4859),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
              ),
            ),
            Icon(
              Icons.notifications_none,
              size: 30,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 13, bottom: 16),
                  child: Text(
                    'What do you think ?',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'About us !',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(statement.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: statement[index]['color'],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: statement[index]['title'],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            statement[index]['image']
                          ],
                        ),
                      ),
                    );
                  }))),
              SizedBox(
                height: 15,
              ),
              Text(
                'Best rating ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(rating.length, (index) {
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // rating[index]['column'],
                              rating[index]['avatar'],
                              SizedBox(
                                width: 10,
                              ),
                              rating[index]['column'],
                            ]),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    )*/
    ; /*StreamBuilder<QuerySnapshot>(
        stream: users.where('uid', isEqualTo: currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<UserModel> userdata = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              userdata.add(UserModel.fromJson(snapshot.data!.docs[i]));
            }
            return Padding(
              padding: const EdgeInsets.only(
                  top: 70, right: 20, left: 20, bottom: 8),
              child: Scaffold(
                key: key,
                drawer: Drawer(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 70, right: 20, left: 20, bottom: 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, 'EditProfile');
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color(0xff3A4859),
                                    ),
                                    /* Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1.6,
                                  color: Colors.white,
                                )
                            ),
                            child: Icon(Icons.person,size: 35,color: Colors.white,
                            ),
                          ),
                        )*/
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                              width: 1.6,
                                              color: Colors.white,
                                            )),
                                        child: Icon(
                                          Icons.person,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ) /*Obx(()=>authController.myUser.value.image==null?Center(child: CircularProgressIndicator())
                         :Image(image:NetworkImage(authController.myUser.value.image!),fit: BoxFit.fill)),*/
                                    ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                userdata[0].email,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff3A4859),
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign Out',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () async {
                                      GoogleSignIn googleSignIn =
                                          GoogleSignIn();
                                      googleSignIn.disconnect();
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Homepage_2()));
                                    },
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Edit Profile',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 17,
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditProfile()));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                              children: List.generate(account.length, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                account[index]['title'],
                                SizedBox(
                                  height: 30,
                                ),
                                account[index]['icon'],
                              ],
                            );
                          })),
                        ]),
                  ),
                ),
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () {
                      key.currentState!.openDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff3A4859),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                width: 1.6,
                                color: Colors.white,
                              )),
                          child: Icon(
                            Icons.person,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                        //Image(image:NetworkImage(authController.myUser.value.image!),fit: BoxFit.fill,))
                      ),
                    ),
                  ),
                  title: Text(
                    userdata[0].email,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xff3A4859),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    Icon(
                      Icons.notifications_none,
                      size: 30,
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 13, bottom: 16),
                          child: Text(
                            'What do you think ?',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'About us !',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children:
                                  List.generate(statement.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                width: 95,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: statement[index]['color'],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: statement[index]['title'],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    statement[index]['image']
                                  ],
                                ),
                              ),
                            );
                          }))),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Best rating ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(rating.length, (index) {
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
                                      rating[index]['column'],
                                    ]),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('No data avaible right now');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });*/
  }
}
