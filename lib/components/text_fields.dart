import 'package:flutter/material.dart';

class TextFields extends StatelessWidget{
  final String hinttxt;
  final TextEditingController controller;
  final bool obscure;
  final FocusNode? focusNode;
  const TextFields ({
    super.key,
    required this.hinttxt,
    required this.controller,
    this.obscure = false,
    this.focusNode,
    });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hinttxt,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        obscureText: obscure,
      ),
    );
  }
}