import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Onboarding/onboarding.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.8;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CupertinoColors.systemRed.color,
        body: Padding(
          padding: EdgeInsets.only(top: 50,left: 50),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 60,),
                Text("Welcome to Ecommerce",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: CupertinoColors.white),textAlign: TextAlign.end,),
                SizedBox(height: width * 0.02,),
                Text("let's go for online shopping ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: CupertinoColors.white),textAlign: TextAlign.center,),
                SizedBox(height: width * 1.6,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    minimumSize:Size(width * 0.9, 50),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignupView()));
                  },
                  child: Text("Next",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: CupertinoColors.systemRed),textAlign: TextAlign.center,),
                ),

              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: CupertinoColors.quaternaryLabel)
            ),
          ),
        ),
      ),
    );
  }
}
