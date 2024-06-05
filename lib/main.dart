import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/Json_data/Book_Container.dart';
import 'package:project/Pages/BestLawyers.dart';
import 'package:project/Pages/Dashboard_page.dart';
import 'package:project/Pages/Edit_Profile.dart';
import 'package:project/Pages/Home_Page.dart';
import 'package:project/Pages/Login_Page.dart';
import 'package:project/Pages/SignUp_Page.dart';
import 'package:project/Pages/Specilization_Page.dart';
import 'package:project/Pages/Video_Player.dart';
import 'package:project/Pages/chat_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*await FirebaseAppCheck.instance.activate(
    //webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
  );*/
  runApp(LawyerApp());
}

class LawyerApp extends StatefulWidget {
  const LawyerApp({super.key});

  @override
  State<LawyerApp> createState() => _LawyerAppState();
}

class _LawyerAppState extends State<LawyerApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //AuthController authController=Get.put(AuthController());
    //authController.decideRoute();
    return MaterialApp(
      initialRoute: 'HomePage',
      routes: {
        'DashboardPage': (context) => const DashboardPage(),
        'ChatPage': (context) => const ChatPage(),
        //'ProfilePage':(context) => const ProfilePage(),
        'EditProfile': (context) => const EditProfile(),
        'HomePage': (context) => const HomePage(),
        'SignUpPage': (context) => const SignUp_Page(),
        'BestLawyers': (context) => const BestLawyers(),
        'VideoPlayer': (context) => const VideoPlayers(),
        'BookContainer': (context) => const BookContainer(),
        'SpecilizationPage': (context) => const Specilization_Page(),
      },
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? HomePage()
          : LoginPage(),
    );
  }
}
