import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BookContainer extends StatefulWidget {
  const BookContainer({super.key});

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(
            blurRadius: 5,
            spreadRadius: 5,
            color: Colors.grey.withOpacity(0.1),
        )]
        ),
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Books_01',style: TextStyle(color: Colors.blue),),
                  Text('24 jun 2024',style: TextStyle(color: Colors.grey),),
                ],
              ),
              ListTile(
              title: Text('jjghrtrasdfghjkhuygtrdeswaesrdtfyg',maxLines: 2,
                  style: TextStyle(fontSize: 22,color: Colors.black),),
              subtitle: Text('ddfghjkjhytrfdesdrftgyhujiuhygtfr',maxLines: 1,
                  overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,color: Colors.grey),),
            ),

            ]
          ),
        ),
         ),
    );
  }
}
