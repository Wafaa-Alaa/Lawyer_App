import 'package:flutter/material.dart';
import 'package:project/Pages/BestLawyers.dart';
import 'package:project/Pages/Home_Page.dart';
import 'package:project/Pages/Section_Page.dart';
import 'package:project/Pages/chat_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _HomePageState();
}

class _HomePageState extends State<DashboardPage> {
  int currentindex = 0;
  List screens = [
    // BestLawyers(),
    HomePage(),
    SectionPage(),
    ChatPage(),
  ];
  @override
  Widget build(BuildContext context) {
    var emaill = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (int newindex) {
          setState(() {
            currentindex = newindex;
          });
        },
        iconSize: 30,
        selectedItemColor: Color(0xff66280E),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff66280E),
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.black,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined), label: 'Sections'),
          //BottomNavigationBarItem(icon: Icon(Icons.)),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            // icon: IconButton(
            //   icon: Icon(Icons.chat_bubble),
            //   onPressed: () {
            //     Navigator.pushNamed(context, 'ChatPage', arguments: emaill);
            //   },
            // ),
            label: 'Chat',
          ),
        ],
      ),
      body: screens.elementAt(currentindex),
    );
  }
}
