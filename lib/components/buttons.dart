import 'package:flutter/material.dart';

class Buttons extends StatelessWidget{
  final String title;
  final void Function() ? ontap;
  const Buttons({
    super.key,
    required this.title,
    required this.ontap,
  });
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),  
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Text(title),
      ),
    );
  }
}