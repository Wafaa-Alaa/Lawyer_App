/*
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:project/Pages/Home_Page.dart';
import 'package:project/Pages/Profile_Page.dart';
import 'package:path/path.dart' as Path;
import '../Json_data/user_model.dart';

class AuthController extends GetxController
{
  var isProfileUploading=false.obs;
  var myUser=UserModel().obs;
  getUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).snapshots().listen((
        event) {
      myUser.value = UserModel.fromJson(event.data()!);
    });
  }
  decideRoute(){
    // check user Login
    User? user=FirebaseAuth.instance.currentUser;
    if(user!=null && FirebaseAuth.instance.currentUser!.emailVerified)
      {
        //// check whwther user exist profile
        FirebaseFirestore.instance.collection('users').doc(user.uid).get()
            .then((value){
              if(value.exists) {
                Get.to(() => HomePage());
              }
              else
                {
                  Get.to(()=>ProfilePage());

                }
        } );
      }
  }
  uploadImage(File image)async{
    String imageUrl='';
    String fileName=Path.basename(image.path);
    var reference=FirebaseStorage.instance.ref().child('users/$fileName');
    UploadTask uploadTask=reference.putFile(image);
    TaskSnapshot taskSnapshot=await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value){
      imageUrl=value;
      print('Downloaded URL :$value');
    });
    return imageUrl;
  }
  storeUserInfo(File? selectedimage,String name,String email,String phone,String location,String specialization,String workE,{String url=''})async{
    String url_new=url;
    if(selectedimage!=null){
       url_new=await uploadImage(selectedimage!);
    }
    String uid=FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image':url_new,
      'fullName':name,
      'email':email,
      'phone':phone,
      'location':location,
      'specialization':specialization,
      'workE':workE,
    }).then((value){
      isProfileUploading(false);
      Get.to(() => HomePage());
    });
  }
}*/