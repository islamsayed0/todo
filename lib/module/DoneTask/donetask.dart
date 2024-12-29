import 'package:flutter/material.dart';

class donetask extends StatefulWidget {
  const donetask({super.key});

  @override
  State<donetask> createState() => _donetaskState();
}

class _donetaskState extends State<donetask> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('donetask',style: TextStyle(
        fontSize: 45,
      ),),
    );
  }
}
