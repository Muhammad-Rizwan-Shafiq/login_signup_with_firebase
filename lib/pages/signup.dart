import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  final _signupformKey = GlobalKey<FormState>();

  var email=" ";
  var password=" ";
  var confirmPassword=" ";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController=TextEditingController();


  userSignup() async{
   if(password == confirmPassword){
    try{
      UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:Text("Register Successfully",style: TextStyle(fontSize: 20,color: Colors.white),),
        backgroundColor: Colors.grey,
      ));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    }on FirebaseAuthException catch(error){
null;
    }


    }else{
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content:Text("Password Doest not Match",style: TextStyle(fontSize: 20,color: Colors.white),),
       backgroundColor: Colors.red,
     ));

   }






   }



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }




  Widget build(BuildContext context) {

    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _signupformKey,
        child: ListView(
          children: [
            Image.asset("assets/images/signup.png"),
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
              padding: EdgeInsets.all(_width * 0.03),
              child: TextFormField(
                controller: confirmPasswordController,
                cursorColor: Colors.blue,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Confirm Password",
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
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(fontFamily: "Montserrat-Regular"),
                    labelStyle: TextStyle(
                        color: Colors.black, fontFamily: "Montserrat-Regular")),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.blue,
              onPressed: (){
                setState(() {
                  if(_signupformKey.currentState!.validate()){
                    email=emailController.text;
                    password=passwordController.text;
                    confirmPassword=confirmPasswordController.text;
                  }
                });
                userSignup();
              },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Signup",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Already have an account ?"),

                  TextButton(
                    onPressed: () {

                    },
                    child: Text("Login" ,style: TextStyle( fontSize: 16)),
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
