import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var email = " ";
  var password = " ";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
    }
    on FirebaseAuthException catch(error){
      if(error.code == 'user-not-found'){
        print("No User found with this Email Address");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.blueGrey,
              content: Text("No User found with this Email Address",style: TextStyle(color: Colors.white),)
          ),
        );
      }
      else if(error.code == 'wrong-password'){
        print("Wrong Password Provided by user");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.blueGrey,
              content: Text("Wrong Password Provided by user",style: TextStyle(color: Colors.white),)
          ),
        );
      }
    }

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            Image.asset("assets/images/login.jpg"),
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
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_width * 0.03),
              child: TextFormField(
                controller: passwordController,
                cursorColor: Colors.blue,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Enter Password",
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
                    hintText: "Enter your password",
                    hintStyle: TextStyle(fontFamily: "Montserrat-Regular"),
                    labelStyle: TextStyle(
                        color: Colors.black, fontFamily: "Montserrat-Regular")),
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
                        if(_formKey.currentState!.validate()){
                          email=emailController.text;
                          password=passwordController.text;
                        }
                      });
                      userLogin();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password ?"),
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

                    },
                    child: Text("Sign Up" ,style: TextStyle( fontSize: 16)),
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
