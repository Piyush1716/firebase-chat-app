import 'package:flutter/material.dart';
import 'package:temp/services/auth/auth_services.dart';
import 'package:temp/components/buttons.dart';
import 'package:temp/components/text_fields.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController email_cnt = TextEditingController();
  final TextEditingController pw_cnt = TextEditingController();
  final TextEditingController cfpw_cnt = TextEditingController();
  final void Function() ontap;
  RegisterPage({super.key, required this.ontap});

  void register(BuildContext context) async{
    Authentication auth = Authentication();
    if(email_cnt.text != '' && pw_cnt.text != '' && cfpw_cnt.text != '' && pw_cnt.text == cfpw_cnt.text){
      try{
        await auth.signup(email_cnt.text, pw_cnt.text, cfpw_cnt.text);
      }
      on Exception catch(e){
        showDialog(context: context, builder: (context)=> AlertDialog(title: Text(e.toString()),));
      }
    }
    else{
     showDialog(context: context, builder: (context)=> AlertDialog(title: Text("Passwords dosen't matched! "),)); 
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
          "First time on our app",
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
        
        // cnfm pw fields
        TextFields(hinttxt: 'Confirm Password', controller: cfpw_cnt, obscure: true),
        SizedBox(height: 20,),
      
        // login button
        Buttons(title: 'Sign up', ontap: ()=> register(context),),
        SizedBox(height: 20,),

        // register
        Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
          Text('Already a member? '),
          GestureDetector(
            onTap: ontap,
            child: Text('Login Now', style: TextStyle(
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