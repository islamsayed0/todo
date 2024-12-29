import 'package:flutter/material.dart';

class todo extends StatefulWidget {
  const todo({super.key});

  @override
  State<todo> createState() => _todoState();
}

class _todoState extends State<todo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Todo',style: TextStyle(
        fontSize: 45,
      ),),
    );
  }
}
