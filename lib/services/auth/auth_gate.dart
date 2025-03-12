import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temp/services/auth/login_or_register.dart';
import 'package:temp/pages/homePage.dart';

class AuthGate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            return HomePage(ontap: (){});
          } else {
            return Login_Register();
          }
        }
      )
    ,);
  }
}