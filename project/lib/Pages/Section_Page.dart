import 'package:flutter/material.dart';
import 'package:project/Json_data/List_Sections.dart';
import 'package:project/Pages/Dashboard_page.dart';
import 'package:project/Pages/Home_Page.dart';

class SectionPage extends StatefulWidget {
  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sections',style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25
                    ),),
                    IconButton(onPressed:(){},
                        icon:Icon(Icons.search,size: 35,)
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder:(_)=>DashboardPage()));
                  },
                  child: Wrap(
                   children: List.generate(section.length, (index){
                     return Padding(
                       padding: const EdgeInsets.only(right: 8,bottom: 8),
                       child: Container(
                         height: 200,
                         width: 100,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(30),
                           color: section[index]['color'],
                  
                         ),
                         child:Center(
                           child: section[index]['title'],
                         )
                  
                       ),
                     );
                   })
                  ),
                )
              ],
            ),
          ),
        ),
      ),


      );
  }
}
