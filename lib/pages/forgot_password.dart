import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/login.dart';
import 'package:flutter_firebase_app/pages/signup.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  var email = " ";
  final emailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueGrey,
          content: Text(
            "Password reset email sent to your Email",
            style: TextStyle(color: Colors.white),
          )));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print("There is no user availible with this Email address");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "There is no user availible with this Email Address",
              style: TextStyle(color: Colors.white),
            )));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Image.asset("assets/images/forget.jpg"),
            Padding(
              padding: EdgeInsets.all(_width * 0.03),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.blue,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Enter Email",
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(color: Colors.black),
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(fontFamily: "Montserrat-Regular"),
                    labelStyle: TextStyle(
                        color: Colors.black, fontFamily: "Montserrat-Regular")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please insert your email";
                  } else if (!value.contains("@")) {
                    return "Please enter correct email ";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          email = emailController.text;
                        }
                      });
                      resetPassword();

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Send Email",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Login"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Donot have an account ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Signup()));
                    },
                    child: Text("Sign Up", style: TextStyle(fontSize: 16)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
