import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:project/Pages/Login_Page.dart';
import 'package:project/Pages/fire_base_User.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({super.key});

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page>{
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  Fire_User user = Fire_User();
  bool isLoading = false;
  String? country;
  bool hide = true;
  //////////////
  File? file;
   String? url;
  getImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    final XFile? imagecamera =
        await picker.pickImage(source: ImageSource.gallery);
    // Pick an image.
    //final XFile? imagegallery = await picker.pickImage(source: ImageSource.gallery);
    if (imagecamera != null) {
      file = File(imagecamera!.path);
      var imagename = basename(imagecamera!.path);
      var refStoreg = FirebaseStorage.instance.ref(imagename);
      await refStoreg.putFile(file!);
      url = await refStoreg.getDownloadURL();
      
    }
    setState(() {
    
    });
  }
  /////////////
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    //color: Colors.red,
                  ),
                  child: Form(
                    key: formstate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 50, right: 50),
                          child: Text(
                            'DIGITAL EGYPTION LAW',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23,
                              height: 1.6,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120, right: 80),
                          child: Text(
                            'Welcome back sir!',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              height: 1.6,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 150, right: 80),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border(
                                    bottom: BorderSide(
                                  color: Color(0xff66280E),
                                  width: 3,
                                ))),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 25,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ),
                       Padding(
                         padding: const EdgeInsets.only(left:120,top: 8,bottom: 8),
                         child: Stack(
                          children: [
                            user.url != null?
                             CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(user.url!),
                            ): CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage('https://www.pngmart.com/files/22/User-Avatar-Profile-Download-PNG-Isolated-Image.png'),
                            ),
                            Positioned(
                              child:IconButton(
                              onPressed: ()async{
                                user.getImage();
                               // getImage();
                                setState(() {
                                  
                                });
                              },
                              icon:Icon(Icons.add_a_photo) ),
                              bottom: -10,
                              left: 60,
                            )
                          ],
                         ),
                       ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            TextFormField(
                              validator: (data) {
                                if (data == "") return 'Cant To be Empty !';
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xff66280E),
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  prefixIcon: Icon(Icons.person),
                                  prefixIconColor:
                                      Colors.black.withOpacity(0.4),
                                  hintText: 'egyptionlaw',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'E-mail',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            TextFormField(
                              onChanged: (data) {
                                email.text = data;
                              },
                              validator: (data) {
                                if (data == "") return 'Cant To be Empty !';
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xff66280E),
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  prefixIcon: Icon(Icons.email),
                                  prefixIconColor:
                                      Colors.black.withOpacity(0.4),
                                  hintText: 'digitalegyptionlaw@gmail.com',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            TextFormField(
                              obscureText: hide,
                              onChanged: (data) {
                                password.text = data;
                              },
                              validator: (data) {
                                if (data == "") return 'Cant To be Empty !';
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hide = !hide;
                                      });
                                    },
                                    icon: Icon(
                                      hide
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xff66280E),
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  prefixIcon: Icon(Icons.lock),
                                  prefixIconColor:
                                      Colors.black.withOpacity(0.4),
                                  hintText: '* * * * * * * * *',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            TextFormField(
                              obscureText: hide,
                              validator: (data) {
                                if (data == "") return 'Cant To be Empty !';
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hide = !hide;
                                      });
                                    },
                                    icon: Icon(
                                      hide
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Color(0xff66280E),
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.blue,
                                  )),
                                  prefixIcon: Icon(Icons.lock),
                                  prefixIconColor:
                                      Colors.black.withOpacity(0.4),
                                  hintText: '* * * * * * * * *',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                            height: 80,
                            width: 350,
                            // color: Colors.red,
                            child: Center(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: RadioListTile(
                                        title: Text(
                                          'Lawyer',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        value: 'Lawyer',
                                        groupValue: country,
                                        onChanged: (val) {
                                          setState(() {
                                            country = val;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                        title: Text(
                                          'Other',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        value: 'Other',
                                        groupValue: country,
                                        onChanged: (val) {
                                          setState(() {
                                            country = val;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (formstate.currentState!.validate()) {
                              isLoading = true;

                              setState(() {});
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                user.email = email.text;
                                /* user.addUser(
                                    email.text,
                                    password.text,
                                    email.text,
                                    email.text,
                                    password.text,
                                    email.text,
                                    FirebaseAuth.instance.currentUser!.uid);
                                String id = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc()
                                    .id;
                                print('id===== $id');*/
                                user.addlUser(
                                    email.text,
                                    password.text,
                                    email.text,
                                    email.text,
                                    password.text,
                                    email.text,
                                    FirebaseAuth.instance.currentUser!.uid,
                                   user.url!,
                                    7,
                                  'waff',

                                    );
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.rightSlide,
                                  title: 'Error!',
                                  desc: 'Please Verify Your Email !',
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    FirebaseAuth.instance.currentUser!
                                        .sendEmailVerification();
                                  },
                                )..show();

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Success')));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginPage()));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('weak-password')));
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error!',
                                    desc: 'weak-password.',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show();
                                } else if (e.code == 'email-already-in-use') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('emai already exist')));
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error!',
                                    desc: 'emai already exist.',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show();
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                              }
                              isLoading = false;
                              setState(() {});
                            } else
                              print('Not valid');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff66280E),
                            ),
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: GestureDetector(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xff66280E),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => LoginPage()));
                          },
                        )),
                        Container(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
