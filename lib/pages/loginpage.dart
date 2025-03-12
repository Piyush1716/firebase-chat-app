import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/components/buttons.dart';
import 'package:temp/components/text_fields.dart';
import 'package:temp/pages/homePage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email_cnt = TextEditingController();
  final TextEditingController pw_cnt = TextEditingController();
  final void Function() ontap;
  LoginPage({super.key, required this.ontap});

  void login(BuildContext context)async{
    Authentication auth = Authentication();
    try{
      User? user = await auth.signin(email_cnt.text, pw_cnt.text);
      if(user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(ontap: ontap,)));
      }
      else{
        showDialog(context: context, builder: (context)=> AlertDialog(title: Text('Login Error'),));
      }
    }
    on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context)=> AlertDialog(title: Text('Error'),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        // logo
        Icon(
          Icons.message, size: 50, color: Theme.of(context).colorScheme.primary,
          ),
        // Welcome
        Text(
          "Welcome to our app",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 20,),
      
        // email fields
        TextFields(hinttxt: 'Email', controller: email_cnt),
      
        // pw fields
        TextFields(hinttxt: 'Password', controller: pw_cnt, obscure: true),
        SizedBox(height: 20,),
      
        // login button
        Buttons(title: 'Login', ontap: ()=> login(context),),
        SizedBox(height: 20,),

        // register
        Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
          Text('Not a member? '),
          GestureDetector(
            onTap: ontap,
            child: Text('Register Now', style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),),
          ),
        ],
        )

      ],)
    );
  }

}