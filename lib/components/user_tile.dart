import 'package:flutter/material.dart';

class UserTile extends StatelessWidget{

  final String email;
  final void Function() ? ontap;
  UserTile({required this.email, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 20,),
            Text(email),
          ],
        ),
      ),
    );
  }
}