import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/login.dart';

class ChangePaaword extends StatefulWidget {
  @override
  _ChangePaawordState createState() => _ChangePaawordState();
}

class _ChangePaawordState extends State<ChangePaaword> {
  final _changePasswordFormKey = GlobalKey<FormState>();
  var newPassword=" ";
  var newPasswordController = TextEditingController();

  changePassword() async{
    try{

      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:Text("Password Successfully Updated",style: TextStyle(fontSize: 20,color: Colors.white),),
        backgroundColor: Colors.grey,
      ));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    }catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
     body: Form(
       key: _changePasswordFormKey,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Image.asset("assets/images/change.jpg"),
           Padding(
             padding: EdgeInsets.all(_width * 0.03),
             child: TextFormField(
               controller: newPasswordController,
               cursorColor: Colors.blue,
               style: TextStyle(color: Colors.black),
               decoration: InputDecoration(
                   labelText: "New Password",
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
                   hintText: "Enter New Password",
                   hintStyle: TextStyle(fontFamily: "Montserrat-Regular"),
                   labelStyle: TextStyle(
                       color: Colors.black, fontFamily: "Montserrat-Regular")),
               validator: (value){
                 if(value == null || value.isEmpty){
                   return "Please Enter New Password";
                 }
                 return null;
               },
             ),
           ),
           ElevatedButton(onPressed: (){
             setState(() {
               if(_changePasswordFormKey.currentState!.validate()){
                 newPassword=newPasswordController.text;
               }
             });
             changePassword();
           }, child: Text("Change Password"),),
         ],
       ),
     ),
    );
  }
}
