import 'package:ecommerce/Onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Database/database.dart';
import '../Product/Product_listing/product_listing.dart';
import '../Product/product_listing_provider.dart';
import '../encrypt/encrypt.dart';
import '../popup/popup.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _isObscured = true;
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkIfUserIsLoggedIn();
  }

  Future<void> checkIfUserIsLoggedIn() async {
    _isUserLoggedIn = await DataBaseHelper().isUserLoggedIn();
    if (_isUserLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductListingScreen()));
    }
  }

  Future<bool> loginUser(String? username, String? password) async {
    final storedUsername = await DataBaseHelper().getUserValue('email');
    final storedPassword = await DataBaseHelper().getUserValue('password');
    String passphrase = PasswordEncryptionHelper().passphrase;
    String decryptedPassword = PasswordEncryptionHelper.decryptPassword(storedPassword.toString(), passphrase);
    if (username == storedUsername && password == decryptedPassword) {
      await DataBaseHelper().isUserLoggedIn();
      showDialog(
        context: context,
        builder: (context) => PopupView(
          message: "Login successful!",
          onDone: () {
            DataBaseHelper().saveUserData("username", username!);
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListingScreen()));
          },
          onCancel: () {
            Navigator.pop(context);
          },
        ),
      );
      return true;
    } else {
      // Show error message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid credentials")),
      );
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CupertinoColors.white,
            fontSize: 18,
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.8,
                  height: 50,
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.elliptical(4, 4)),
                      ),
                      labelText: "Enter email or phone number",
                    ),
                  ),
                ),
                SizedBox(height: width * 0.05),
                SizedBox(
                  width: width * 0.8,
                  height: 50,
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
                          _isObscured ? Icons.visibility_off : Icons.visibility,
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
                SizedBox(height: width * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SignInScreen()));
                        },
                        child: Text(
                          "create account first?",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width * 0.02),
                ElevatedButton(
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.white,
                    minimumSize: Size(width * 0.4, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    loginUser(username.text, password.text);
                  },
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.elliptical(40, 40),
                bottomLeft: Radius.elliptical(40, 40),
                topRight: Radius.elliptical(40, 40),
                bottomRight: Radius.elliptical(40, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}