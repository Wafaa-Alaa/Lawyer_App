import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Fire_User extends GetxController {
  //// function  create collection of users
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  GlobalKey<FormState> formstate = GlobalKey();
  addUser(String n, String e, String p, String l, String s, String w,
      String uid,String im,int r) async {
    ///// check to user to enter value in textfield
    DocumentReference response = await users.add({
      'fullName': n,
      'email': e,
      'phone': p,
      'location': l,
      'specialization': s,
      'workE': w,
      'uid': uid,
      'image':im,
      'rateing':r,

    });
  }

//////////////////////////////////
  addlUser(String n, String e, String p, String l, String s, String w,
      String uid,String im,int r) async {
    var collectionRef = FirebaseFirestore.instance.collection('users');

    // Create a new document
    DocumentReference docRef = collectionRef.doc();

    // Get the auto-generated document ID
    String docId = docRef.id;

    // Create a map with the document data, including the document ID
    Map<String, dynamic> data = {
      'fullName': n,
      'email': e,
      'phone': p,
      'location': l,
      'specialization': s,
      'workE': w,
      'uid': uid,
      'id': docId,
      'image':im,
      'rateing':r,
    };

    // Set the data to the document
    await docRef.set(data);
  }

  /////////////////
  addxUser(String n, String e, String p, String l, String s, String w,
      String uid) async {
    var collectionRef = FirebaseFirestore.instance.collection('users');

    // Create a new document
    DocumentReference docRef = collectionRef.doc();

    // Get the auto-generated document ID
    String docId = docRef.id;

    // Create a map with the document data, including the document ID
    Map<String, dynamic> data = {
      'fullName': n,
      'email': e,
      'phone': p,
      'location': l,
      'specialization': s,
      'workE': w,
      'uid': uid,
      'id': docId,
    };
    DocumentReference response = await users.add(data);
  }
  ////////// add document id
  ///////////////Update document of user
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  /////////////// function get data all users of  collection from firestore
  List<QueryDocumentSnapshot> data = [];
  /*getdata()async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('users').get();
    data.addAll(querySnapshot.docs);
  }*/
  //////////////get image

 /* getImage(File? file) async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo.
    final XFile? imagecamera =
        await picker.pickImage(source: ImageSource.camera);
    // Pick an image.
    //final XFile? imagegallery = await picker.pickImage(source: ImageSource.gallery);
    file = File(imagecamera!.path);
  }*/

////////////////email of specific user
  String email = '';
  ////////// function get user
  getSpecificUser(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot userdata = await users.where('email', isEqualTo: email).get();
    userdata.docs.forEach((element) {
      data.add(element);
    });
  }
  /////////////////
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
    
}
}