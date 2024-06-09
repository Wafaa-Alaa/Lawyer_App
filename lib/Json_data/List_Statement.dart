import 'package:flutter/material.dart';

List statement=[
  {
    'title':Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Statement',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
        SizedBox(
          height: 2,
        ),
        Text('1',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
      ],
    ),
    'color': Color(0xff66280E),
    'image':Image(image: AssetImage('assets/images/lawyer_man.jpg',),fit: BoxFit.fill,)

  },
  {

    'title':Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Statement',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
        SizedBox(
          height: 2,
        ),
        Text('2',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
      ],
    ),
    'color': Color(0xff8B5D49),
    'image':Image(image: AssetImage('assets/images/books.jpg'),)
  },
  {

    'title':Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Statement',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
        SizedBox(
          height: 2,
        ),
        Text('3',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
      ],
    ),
    'color': Color(0xff66280E),
    'image':Image(image: AssetImage('assets/images/balance.png'),)
  },
  {

    'title':Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Statement',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
        SizedBox(
          height: 2,
        ),
        Text('4',style: TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontSize: 17,
        ),),
      ],
    ),
    'color': Color(0xff8B5D49),
    'image':Image(image: AssetImage('assets/images/lawyer_man.jpg'),)
  },
];