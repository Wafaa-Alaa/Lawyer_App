/*
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:project/Json_data/user_model.dart';

import 'Home_Page.dart';
import 'class_GEX.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullName=TextEditingController();

  TextEditingController email=TextEditingController();

  TextEditingController location=TextEditingController();

  TextEditingController phone=TextEditingController();

  TextEditingController specialization=TextEditingController();

  TextEditingController workE=TextEditingController();
  final ImagePicker _picker=ImagePicker();
  File? selectedimage;
  getImage(ImageSource source) async
  {

    final XFile? image=await _picker.pickImage(source:source);
    if(image!=null)
      {

        setState(() {
          selectedimage= File(image.path);
        });
      }
  }

  AuthController authController=Get.put(AuthController());

  GlobalKey<FormState> formKey=GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullName.text=authController.myUser.value.fullName??"";
    email.text=authController.myUser.value.email??"";
    phone.text=authController.myUser.value.phone??"";
    location.text=authController.myUser.value.location??"";
    specialization.text=authController.myUser.value.specialization??"";
    workE.text=authController.myUser.value.workE??"";


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, 'HomePage');
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body:SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top:40,left: 16,right: 16,bottom: 8),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Stack(
                    children:[
                      Center(
                      child: InkWell(
                        onTap: (){
                          getImage(ImageSource.camera);
                        },
                        child: selectedimage==null?
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff3A4859),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    width: 1.6,
                                    color: Colors.white,
                                  )
                              ),
                              child: Icon(Icons.person,size: 60,color: Colors.white,
                              ),
                            ),
                          ),
                        )
                            :Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(selectedimage!),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff3A4859),
                          ),
                          )
                        ),
                      ),

                      /*Positioned(
                        right: 15,
                        left: 70,
                        top: 55,
                        child: IconButton(
                            onPressed: (){
                              getImage(ImageSource.camera);
                            },
                            icon: Icon(Icons.add_a_photo,color: Colors.blueGrey,)
                        ),
                      )*/
                        ]
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(authController.myUser.value.fullName==null?'ACCOUNT NAME'
                      :authController.myUser.value.fullName!,style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xff3A4859),
                    fontSize: 20,
                  ),),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (data){
                      if(data!.isEmpty) {
                        return 'Name is required';
                      }
                      if(data!.length<5) {
                        return 'Enter Full Name';
                      }
                      return null;
                    },
                    controller: fullName,
                    style: TextStyle(
                      backgroundColor: Colors.white24,
                  ),
                    decoration: InputDecoration(
                      label: authController.myUser.value.fullName==null?Text('Full Name')
                      :Text(authController.myUser.value.fullName!),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide(
                            color: Colors.black,
                          )
                    ),
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor:
                      Colors.black.withOpacity(0.4),
                  )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                 validator: (data) {
                   if (data!.isEmpty) {
                     return 'Email is required';
                   }
                   return null;
                 },
                    controller: email,
                      decoration: InputDecoration(
                        label: authController.myUser.value.email==null?Text('Email')
                            :Text(authController.myUser.value.email!),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )
                        ),
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor:
                        Colors.black.withOpacity(0.4),
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Phone is required';
                        }
                        return null;
                      },
                    controller: phone,
                      decoration: InputDecoration(
                        label: authController.myUser.value.phone==null?Text('Phone')
                            :Text(authController.myUser.value.phone!),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )
                        ),
                        prefixIcon: Icon(Icons.phone),
                        prefixIconColor:
                        Colors.black.withOpacity(0.4),
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Location is required';
                        }
                        return null;
                      },
                    controller: location,
                      decoration: InputDecoration(
                        label: authController.myUser.value.location==null?Text('Location')
                            :Text(authController.myUser.value.location!),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )
                        ),
                        prefixIcon: Icon(Icons.location_on),
                        prefixIconColor:
                        Colors.black.withOpacity(0.4),
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'Specialization  is required';
                        }
                        return null;
                      },
                    controller: specialization,
                      decoration: InputDecoration(
                        label: authController.myUser.value.specialization==null?Text('Specialization')
                            :Text(authController.myUser.value.specialization!),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )
                        ),
                        prefixIcon: Icon(Icons.balance),
                        prefixIconColor:
                        Colors.black.withOpacity(0.4),
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'WorkE is required';
                        }
                        return null;
                      },
                    controller: workE,
                      decoration: InputDecoration(
                        label: authController.myUser.value.workE==null?Text('WorkE')
                            :Text(authController.myUser.value.workE!),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )
                        ),
                        prefixIcon: Icon(Icons.work),
                        prefixIconColor:       
                        Colors.black.withOpacity(0.4),
                      )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                 Obx(() => authController.isProfileUploading.value?
                 Center(
                   child: CircularProgressIndicator(),
                 ) :
                 InkWell(
                   onTap: () {
                     if(!formKey.currentState!.validate())
                       {
                         return;
                       }
                    /* if (selectedimage == null) {
                       //Get.snackbar('Warnning', 'Please Enter Photo');
                      /* ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text('Warnning ! Please Enter Photo')));*/
                       //return ;
                     }*/
                     authController.isProfileUploading(true);
                     authController.storeUserInfo(selectedimage,fullName.text,
                         email.text,
                         phone.text,
                         location.text,
                         specialization.text,
                         workE.text,url: authController.myUser.value.image??"");
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
                         'Save',
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.bold,
                           fontSize: 28,
                         ),
                       ),
                     ),
                   ),
                 ),),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}*/
