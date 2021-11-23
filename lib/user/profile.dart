import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;
  emailVerify() async {
    if (user != null && user!.emailVerified) {
      await user!.sendEmailVerification();
      print("Verification email has been sent");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text(
              "Verification email has been sent",
              style: TextStyle(color: Colors.white),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/profile.png"),
          SizedBox(
            height: 20,
          ),
          Text(
            "USER ID",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${uid}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "USER EMAIL",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center
            ,
            children: [
              Container(
                width: 150,
                child: Text(
                  "${email}",
                  style: TextStyle(fontSize: 15),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              user!.emailVerified
                  ? Text(
                      "Verfied",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue),
                    )
                  : TextButton(
                      onPressed: () {
                        emailVerify();
                      },
                      child: Text("Send email for verification"))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "CREATED AT",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${creationTime.toString()}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil((context),  MaterialPageRoute(builder: (context)=>Login()), (route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
