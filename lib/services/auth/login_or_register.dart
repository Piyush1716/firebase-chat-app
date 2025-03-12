import 'package:flutter/material.dart';
import 'package:temp/pages/loginpage.dart';
import 'package:temp/pages/registerpage.dart';

class Login_Register extends StatefulWidget{
  State<Login_Register> createState() => _Login_RegisterState();
}
class _Login_RegisterState extends State<Login_Register>{
  bool Login = true;
  ontap(){
    setState((){
      Login = !Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(Login) {
      return LoginPage(ontap: ontap);
    } else {
      return RegisterPage(ontap: ontap);
    }
  }

}