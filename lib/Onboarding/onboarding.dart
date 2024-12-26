import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Database/database.dart';
import '../encrypt/encrypt.dart';
import 'login.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  void _init() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          SizedBox(
            height: width * 0.4,
            width: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                Text(
                  "Onboard yourself to get better management of your lifestyle",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: width * 0.54),
          Container(
            width: width,
            height: width,
            child: Column(
              children: [
                SizedBox(height: width * 0.32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginView()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.7, 50),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.secondaryLabel,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to SignInScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(width * 0.7, 50),
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  child: Text(
                    "Try first",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),

              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(180, 100),
                bottomRight: Radius.elliptical(180, 100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isObscured = true;

  void validateTextfield() {

    if (fullname.text == "" && email.text == "" && phone.text == "" && password.text == "") {
      print("Invalid data");
    } else if (fullname.text.isEmpty) {
      print("enter full name");
    } else if (!email.text.contains('@')) {
      print("enter email");
    } else if (phone.text.length != 10) {
      print("enter phone");
    } else if (password.text.length < 8) {
      print("enter password");
    } else {
      print("Register Success");
      print(email.text);
      print(password.text);
      String encryptedPassword = PasswordEncryptionHelper.encryptPassword(password.text, PasswordEncryptionHelper().passphrase);
      print("Register Success");
      print(email.text);
      print(encryptedPassword);
      DataBaseHelper().saveUserData("fullname", fullname.text);
      DataBaseHelper().saveUserData("email", email.text);
      DataBaseHelper().saveUserData("phone", phone.text);
      DataBaseHelper().saveUserData("password", encryptedPassword);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "Register",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
            fontSize: 18,
            fontStyle: FontStyle.normal,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.left_chevron, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: width * 0.04),
            Container(
              width: width,
              height: width * 1.68,
              child: Column(
                children: [
                  SizedBox(height: width * 0.22),
                  SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      controller: fullname,
                      decoration: InputDecoration(
                        labelText: "Full name",
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.02),
                  SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.02),
                  SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                        labelText: "Phone no",
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.02),
                  SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      controller: password,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility_off : Icons
                                .visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.05),
                  ElevatedButton(
                    onPressed: () {
                      validateTextfield();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(width * 0.5, 48),
                      backgroundColor: CupertinoColors.systemYellow,
                    ),
                    child: Text(
                      "Try first",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.1,),
                  Divider(height: 0.5,color: CupertinoColors.secondarySystemFill,),
                  SizedBox(height: width * 0.1,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(220,66,49, 1),
                              foregroundColor: Colors.white,
                              minimumSize:Size(width * 0.4, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              )
                          ),
                          onPressed: (){

                          },
                          child: Text("Google+",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: CupertinoColors.white),textAlign: TextAlign.center,),
                        ),
                        SizedBox(width: width * 0.03,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                              minimumSize:Size(width * 0.4, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)
                              )
                          ),
                          onPressed: (){

                          },
                          child: Text("Instagram",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: CupertinoColors.systemRed),textAlign: TextAlign.center,),
                        ),
                      ]
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(180, 100),
                  bottomRight: Radius.elliptical(180, 100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}