import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/Pages/Home_Page.dart';
import 'package:project/Pages/Login_Page.dart';

import 'Profile_Page.dart';
/*class Profile{
    decideRoute(){
    //// check user login
    User? user=FirebaseAuth.instance.currentUser;
    if(user!=null)
      {
        //// check user profile exist
        FirebaseFirestore.instance.collection('users').doc(user.uid).get()
            .then((value) {
              if(value.exists) {
               Navigator.pushNamed
              }
              else
                {
                  return false;
                }
        } );
      }
  }


}*/