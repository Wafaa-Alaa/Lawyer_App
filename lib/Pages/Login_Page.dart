import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:project/Pages/Dashboard_page.dart';
import 'package:project/Pages/SignUp_Page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//////////////////////////
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool isLoading = false;
  bool hide = true;
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.push(context, MaterialPageRoute(builder: (_) => DashboardPage()));
  }

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

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
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 25,
                                height: 1.6,
                              ),
                            ),
                          ),
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
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            if (email.text == "") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc:
                                    'Enter your email,Please !,then prees on forgotten password',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();
                                },
                              )..show();
                              return;
                            }
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(email: email.text);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Success',
                                desc:
                                    ' Link is send to your email ,Please go to your email to reset your password !',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'Error',
                                desc: ' Enter Exist Email ,active !',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              )..show();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 246),
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Text('Forgotten Password',
                                style: TextStyle(
                                  // decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (formstate.currentState!.validate()) {
                              isLoading = true;
                              setState(() {});
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                if (credential.user!.emailVerified) {
                                  Navigator.pushNamed(context, 'Dashboard',
                                      arguments: email.text);
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.rightSlide,
                                    title: 'Error!',
                                    desc: 'Please Verify your Email !',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {
                                      FirebaseAuth.instance.currentUser!
                                          .sendEmailVerification();
                                    },
                                  )..show();
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  /* ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(content: Text('No user found for that email.')));*/
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error!',
                                    desc: 'user-not-found',
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () {},
                                  )..show();
                                } else if (e.code == 'wrong-password') {
                                  /*ScaffoldMessenger.of(context).showSnackBar(
                                     SnackBar(
                                         content: Text('Wrong password provided for that user.')));*/
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
                                'lOGIN',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 20,
                              width: 120,
                              child: Divider(
                                color: Colors.black.withOpacity(0.3),
                                thickness: 2,
                              ),
                            ),
                            Text(
                              'Or Login With',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 120,
                              child: Divider(
                                color: Colors.black.withOpacity(0.3),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                signInWithGoogle();
                              },
                              child: Container(
                                height: 70,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image(
                                  image: AssetImage('assets/images/google.png'),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await signInWithFacebook();
                              },
                              child: Container(
                                height: 70,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/Facebook.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: Text(
                          'Don\'t have account',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: GestureDetector(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xff66280E),
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUp_Page()));
                          },
                        )),
                        SizedBox(
                          height: 5,
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
