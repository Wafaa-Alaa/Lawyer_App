import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:project/Json_data/user_model.dart';
import 'package:project/Pages/SignUp_Page.dart';
import 'package:project/Pages/fire_base_User.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser!;
  File? file;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Fire_User user = Fire_User();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController specialization = TextEditingController();
  TextEditingController workE = TextEditingController();
  String? im;
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: users.where('uid', isEqualTo: currentUser.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<UserModel> userdata = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              userdata.add(UserModel.fromJson(snapshot.data!.docs[i]));
            }
            username.text = userdata[0].fullName;
            email.text = userdata[0].email;
            location.text = userdata[0].location;
            phone.text = userdata[0].phone;
            specialization.text = userdata[0].specialization;
            workE.text = userdata[0].workE;
            im = userdata[0].image;
            return Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                    padding: const EdgeInsets.only(
                        top: 80, left: 16, right: 16, bottom: 8),
                    child: ListView.builder(
                        itemCount: userdata.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              /*Stack(children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                  //  await  user.getImage();
                                      // setState(() {});
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xff3A4859),
                                      ),
                                      child:Image.network(im!,fit: BoxFit.fill,) , /*user.url != null
                                          ? Image.network(
                                              user.url!,
                                              fit: BoxFit.fill,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    border: Border.all(
                                                      width: 1.6,
                                                      color: Colors.white,
                                                    )),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )*/
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 55,
                                  right: 10,
                                  left: 70,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                )
                              ]),*/
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ModalProgressHUD(
                                  inAsyncCall: isLoading,
                                  progressIndicator:
                                      CircularProgressIndicator(),
                                  child: Stack(
                                    children: [
                                      user.url == null
                                          ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  NetworkImage(im!),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  NetworkImage(user.url!),
                                            ),
                                      Positioned(
                                        child: IconButton(
                                            onPressed: () async {
                                              isLoading = true;
                                              setState(() {});
                                              user.getImage();
                                              // getImage();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                            icon: IconButton(
                                                onPressed: () async {
                                                  user.getImage();
                                                  setState(() {});
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                ))),
                                        bottom: -10,
                                        left: 60,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                userdata[index].fullName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff3A4859),
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                        // initialValue: userdata[index].fullName,
                                        controller: username,
                                        style: TextStyle(
                                          backgroundColor: Colors.white24,
                                        ),
                                        decoration: InputDecoration(
                                          label: Text('fullName'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          prefixIcon: Icon(Icons.person),
                                          prefixIconColor:
                                              Colors.black.withOpacity(0.4),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                        //initialValue: userdata[index].email,
                                        controller: email,
                                        decoration: InputDecoration(
                                          label: Text('Email'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          prefixIcon: Icon(Icons.email),
                                          prefixIconColor:
                                              Colors.black.withOpacity(0.4),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                        // initialValue: userdata[index].email,
                                        controller: phone,
                                        decoration: InputDecoration(
                                          label: Text('Phone Number'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          prefixIcon: Icon(Icons.phone),
                                          prefixIconColor:
                                              Colors.black.withOpacity(0.4),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                        //initialValue: userdata[index].fullName,
                                        controller: location,
                                        decoration: InputDecoration(
                                          label: Text('Location'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          prefixIcon: Icon(Icons.location_on),
                                          prefixIconColor:
                                              Colors.black.withOpacity(0.4),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                        //initialValue: userdata[index].fullName,
                                        controller: specialization,
                                        decoration: InputDecoration(
                                          label: Text('Specialization'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          prefixIcon: Icon(Icons.balance),
                                          prefixIconColor:
                                              Colors.black.withOpacity(0.4),
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                        //initialValue: userdata[index].fullName,
                                        controller: workE,
                                        decoration: InputDecoration(
                                          label: Text('Work Experience'),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              )),
                                          prefixIcon: Icon(Icons.work),
                                          prefixIconColor:
                                              Colors.black.withOpacity(0.4),
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  updateUser(userdata);
                                  Navigator.pushNamed(context, 'HomePage');
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
                                      'UPDATE',
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
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  await users.doc(userdata[0].id).delete();
                                  Navigator.pushNamed(context, 'HomePage');
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
                                      'DELETE',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            // return Center(child: CircularProgressIndicator());
                          );
                        })));
          } else if (snapshot.hasError) {
            return Text('No data avaible right now');
          } else
            return SignUp_Page();
          Center(child: CircularProgressIndicator());
          ;
        });
  }

  updateUser(List<UserModel> userdata) async {
    try {
      await users.doc(userdata[0].id).update({
        'fullName': username.text,
        'email': email.text,
        'phone': phone.text,
        'location': location.text,
        'specialization': specialization.text,
        'worke': workE.text,
        'image': user.url != null ? user.url : userdata[0].image,
      });
    } catch (e) {
      Text('Error eccur');
    }
  }
}

/* if(snapshot.connectionState==ConnectionState.done)
                  {
                    if(snapshot.hasData){
                      UserModel userData=snapshot.data as UserModel;
                      return Column(
                        children: [
                          Stack(
                              children:[
                                Center(
                                  child: Container(
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
                                  ),
                                ),
                                Positioned(
                                  top: 55,
                                  right: 10,
                                  left: 70,
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.add_a_photo,color: Colors.blue,)
                                  ),
                                )
                              ]
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text('Account_name',style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Color(0xff3A4859),
                            fontSize: 20,
                          ),),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                            initialValue:userData.fullName,
                                    style: TextStyle(
                                      backgroundColor: Colors.white24,
                                    ),
                                    decoration: InputDecoration(
                                      label: Text('Full Name'),
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
                                    initialValue:userData.email,
                                    decoration: InputDecoration(
                                      label: Text('Email'),
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
                                    initialValue:userData.phone,
                                    decoration: InputDecoration(
                                      label: Text('Phone Number'),
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
                                    initialValue:userData.location,
                                    decoration: InputDecoration(
                                      label: Text('Location'),
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
                                    initialValue:userData.specialization,
                                    decoration: InputDecoration(
                                      label: Text('Specialization'),
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
                                    initialValue:userData.workE,
                                    decoration: InputDecoration(
                                      label: Text('Work Experience'),
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
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: (){},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xff66280E),
                              ),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  'UPDATE',
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
                            height: 20,
                          ),

                        ],
                      );
                    }
                    else if(snapshot.hasError)
                      {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                    else
                      {
                        return Center(child: Text('Something went wrong'));
                      }
                  }
                else
                  {
                   return  Center(child: CircularProgressIndicator());
                  }*/
