import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Json_data/Book_Container.dart';
import 'package:project/Pages/Custom_bookAppbar.dart';
class Specilization_Page extends StatefulWidget {
  const Specilization_Page({super.key});

  @override
  State<Specilization_Page> createState() => _Specilization_PageState();
}

class _Specilization_PageState extends State<Specilization_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(30),
         child: Column(
           children: [
             CustomBookAppbar(),
              Expanded(
                child: ListView.builder(itemBuilder:(context,index){
                  return BookContainer();
                }),
              )

           ],
         ),
       ),
      ),
    );
  }
}
