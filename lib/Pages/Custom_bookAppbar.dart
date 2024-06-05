import 'package:flutter/material.dart';
class CustomBookAppbar extends StatefulWidget {
  const CustomBookAppbar({super.key});

  @override
  State<CustomBookAppbar> createState() => _CustomBookAppbarState();
}

class _CustomBookAppbarState extends State<CustomBookAppbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32,bottom:17),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Criminal Law',style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900
          ),),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Books',style:TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
              ),),
              IconButton(
                  onPressed:(){},
                  icon:Icon(Icons.search)
              )
            ],
          )
        ],
      ),
    );
  }
}
