import 'package:flutter/material.dart';
import 'package:project/Pages/Login_Page.dart';
import 'package:project/Pages/SignUp_Page.dart';

class Homepage_2 extends StatelessWidget {
  const Homepage_2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
          Image(image: AssetImage('assets/images/background_image.jpg'),height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.only(
                top:550,

              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff66280E),
                        ),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child:Center(
                          child: Text('LOG IN',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp_Page()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff66280E),
                        ),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text('Sign Up',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
    ));
  }
}
