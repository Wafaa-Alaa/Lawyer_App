import 'package:flutter/material.dart';
import 'package:project/Pages/HomePage_2.dart';

class HomePage_1 extends StatelessWidget {
  const HomePage_1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: GestureDetector(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder:(_)=>Homepage_2()));
  },
    child: Image(image: AssetImage('assets/images/background_image.jpg'),height: MediaQuery.of(context).size.height,fit: BoxFit.cover,)),
    );
  }
}
